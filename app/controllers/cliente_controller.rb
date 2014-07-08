class ClienteController < ApplicationController

	def index
		@cliente = Cliente.all
	end

	def add
		@cliente = Cliente.new
		@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
		@tp_cliente = params[:tp_cliente]
	end

	def add_cliente
		@cliente = Cliente.new(cliente_params)
		if @cliente.save
			flash[:notice] = "Criado"
			redirect_to :action => :index
		else
			@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
			@tp_cliente = params[:tp_cliente]
			flash[:error] = "Não criado"
			render(:action => "add")
		end
	end

	def editar
		@cliente = Cliente.where("id = ?", params[:cliente_id])[0]
		@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
		@tp_cliente = params[:tp_cliente]
		@cliente_id = params[:cliente_id]
	end

	def update
		@cliente = Cliente.where("id = ?", params[:clitente_id])[0]
		@cliente.update_attributes(cliente_params)
		if @cliente.save
			flash[:notice] = "Cliente alterado com sucesso!"
			redirect_to :action => :editar , :cliente_id => @cliente.id , :tp_cliente => params[:tp_cliente]
		else
			@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
			@tp_cliente = params[:tp_cliente]
			flash[:error] = "Não criado"
		end
	end

	private
		def cliente_params
			params.require(:cliente).permit(:nome , :tp_cliente , :sexo , :dt_nascimento , :rg ,
																			:ssp , :cpf , :naturalidade , :nome_mae , :nome_pai , 
																			:rz_social , :ie , :cnpj , :nome_responsavel , :cep , 
																			:endereco , :numero , :complemento , :bairro , :cidade ,
																			:estado , :email , :telefone1 , :telefone2 , :telefone3 , :celular)
		end

end