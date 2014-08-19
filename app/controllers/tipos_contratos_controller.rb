class TiposContratosController < ApplicationController
	before_filter :authorize
	def index
		@tp_contrato = TipoContrato.all
	end

	def add
		@tp_contrato = TipoContrato.new
	end

	def create
		@tp_contrato = TipoContrato.new(params_tipo_contrato)
		if @tp_contrato.save
			flash[:notice] = "Tipo de contrato criado com sucesso!"
			redirect_to :controller => "contratos" , :action => "index"
		else
			render(:action => :new)
			flash[:error] = "Tipo de contrato não criado"
		end
	end

	def editar
		@tp_contrato = TipoContrato.where("id = ?" , params[:tp_contrato_id])[0]	
	end

	def update
		@tp_contrato = TipoContrato.where("id = ?" , params[:tp_contrato_id])[0]
		@tp_contrato.update_attributes(params_tipo_contrato)
		if @tp_contrato.save
			flash[:notice] = "Tipo de contrato alterado com sucesso!"
			redirect_to :controller => "contratos" , :action => "index"
		else
			render(:action => :editar)
			flash[:error] = "Tipo de contrato não alterado!"
		end		
	end

	def status
		tp_contrato = TipoContrato.where("id = ?" , params[:tp_contrato_id])[0]
		tp_contrato.update_attributes(:status => params[:acao])
		flash[:notice] = "Tipo de contrato alterado com sucesso!"
		redirect_to :action => "index"
	end

	private
		def params_tipo_contrato
			params.require(:tipo_contrato).permit(:nome , :descricao )
		end
end