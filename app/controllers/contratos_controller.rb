class ContratosController < ApplicationController
	
	def index
		
	end

	def add
		@contrato = Contrato.new
		@cliente = Cliente.where("status = ? AND inativo = ?", false , false)								
		@tp_contrato = TipoContrato.where("status = ?", false)
	end

	def add_contrato
		@contrato = Contrato.new(contrato_params)
		if @contrato.save
			flash[:notice] = "Contrato criado com sucesso!"
			redirect_to :action => :index
		else
			@cliente = Cliente.where("status = ? , situacao = ?", false , false)
			@servico = Servico.where("status = ?", false)
			flash[:error] = "Contrato não criado!"
			render(:action => "new")
		end
	end
end