class LoginController < ApplicationController
	
	def index	
	end

	def login
		login = Funcionario.autenticar(params[:usuario] , params[:senha])
		if login and login.status == true
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

	def logout
		session[:usuario_id] = nil
		flash[:notice] = "Usuário delogado com sucesso!"
		redirect_to root_url
	end
end