class LoginController < ApplicationController
	require 'digest/md5'

	def index
		if not session[:usuario_id].blank?
			redirect_to(:controller => "menu" , :action => "index")
		end
	end

	def login
		login = Funcionario.autenticar(params[:usuario] , params[:senha])
		if login and login.senha == Digest::MD5.hexdigest(login.usuario + "1234")
			flash[:notice] = "Por favor altere sua senha!"
			redirect_to(:action => "editar_senha" , :funcionario_id => login.id)
		elsif login and login.status == true
			flash[:error] = "Usuário bloqueado por favor contact o administrador!"
			redirect_to root_url
		elsif login
			session[:usuario_id] = login.id
			flash[:notice] = "Bem vindo #{login.nome}!"
			redirect_to(:controller => "menu" , :action => "index")
		else
			flash[:error] = "Usuário ou senha inválidos!"
			redirect_to root_url
		end
	end

	def editar_senha
		@login = Funcionario.where("id = ?" , params[:funcionario_id])[0]
	end

	def alterar_senha
		if params[:senha].blank?
			flash[:error] = "A senha não pode ficar em branco!"
			redirect_to(:back)
		elsif params[:senha_confirm] != params[:senha] 
			flash[:error] = "A confirmação de senha não correpode com a senha!"
			redirect_to(:back)
		else
			usuario = Funcionario.where("id = ?" , params[:funcionario_id])[0]
			login = Funcionario.trocar_senha(usuario.usuario , params[:senha].to_s , usuario.id)
			session[:usuario_id] = usuario.id
			flash[:notice] = "Senha alterada com sucesso!"
			redirect_to(:controller => "menu" , :action => "index")
		end
	end

	def logout
		session[:usuario_id] = nil
		flash[:notice] = "Usuário delogado com sucesso!"
		redirect_to root_url
	end
end