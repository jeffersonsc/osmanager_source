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

	private
		def cliente_params
			params.require(:cliente).permit!
		end

end