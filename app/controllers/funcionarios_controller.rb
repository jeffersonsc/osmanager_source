class FuncionariosController < ApplicationController

	def index
		@funcionario = Funcionario.buscar(params[:busca] , params[:page])
	end
	def add
		@funcionario = Funcionario.new
		@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
		@cargo = Cargo.where("status = ?", false)
	end

	def add_funcionario
		@funcionario = Funcionario.new(funcionario_params)
		if @funcionario.save
			flash[:notice] = "Funcionario criado com sucesso"
			redirect_to :action => :editar, :funcionario_id => @funcionario.id
		else
			@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
			@cargo = Cargo.where("status = ?", false)
			flash[:error] = "O funcionario não foi criado"
			render(:action => "add")
		end
	end

	def editar
		@funcionario = Funcionario.where("id = ?", params[:funcionario_id])[0]
		@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
		@cargo = Cargo.where("status = ?", false)
	end

	def update
		@funcionario = Funcionario.where("id = ?", params[:funcionario_id])[0]
		@funcionario.update_attributes(funcionario_params)
		if @funcionario.save
			flash[:notice] = "Funcionário alterado com sucesso!"
			redirect_to :action => :editar , :funcionario_id => @funcionario.id 
		else
			@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
			@cargo = Cargo.where("status = ?", false)
			flash[:error] = "Alterações não foram realizadas"
			render(:action => "editar")
		end
	end

	def detalhes
		@funcionario = Funcionario.where("id = ?", params[:funcionario_id])
	end

	def status
		if params[:acao] == "bloquear"
			sql = true
			msg = "Funcionario bloquear com sucesso!"
		elsif params[:acao] == "desbloquear"
			sql = false
			msg = "Funcionario desbloqueado com sucesso!"
		end
			@funcionario = Funcionario.where("id = ?", params[:funcionario_id])[0]
			@funcionario.update_attributes(:status => sql)
			flash[:notice] = "#{msg}"
			redirect_to :action => :index
	end

	def criar_login
		if params[:usuario].blank?
			flash[:error] = "O campo usuáro não pode ficar em branco"
			redirect_to :back
		else
			@login = Funcionario.gera_login(params[:usuario] , params[:funcionario_id])
			flash[:notice] = "Usuario criado com sucesso"
			redirect_to :back
		end
	end

	def resaturar_senha
		@login = Funcionario.senha_padrao(params[:funcionario_id])
		flash[:notice] = "Senha restaurada para padrão"
		redirect_to :back
	end

	private
		def funcionario_params
			params.require(:funcionario).permit(:nome , :sexo , :dt_nascimento , :rg ,
																			:ssp , :cpf , :naturalidade , :nome_mae , :nome_pai ,
																		 	:nome_responsavel , :cep ,
																			:endereco , :numero , :complemento , :bairro , :cidade ,
																			:estado , :email , :telefone , :celular ,:cargo_id )
		end

end