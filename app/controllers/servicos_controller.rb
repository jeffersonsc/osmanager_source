class ServicosController < ApplicationController
	
	before_filter :authorize
	def index
		@servico = Servico.all		
	end

	def add
		@servico = Servico.new
	end

	def add_servico
		@servico = Servico.new(servicos_params)
		if @servico.save
			flash[:notice] = "Servico criado com sucesso"
			redirect_to :action => "index"
		else
			flash[:error] = "Serviço não criado!"
			render(:action => "add")
		end
	end

	def editar
		@servico = Servico.where("id = ?", params[:servico_id])[0]
	end

	def update
		@servico = Servico.where("id = ?", params[:servico_id])[0]
		@servico.update_attributes(servicos_params)
		if @servico.save
			flash[:notice] = "Serviço alterado com sucesso!"
			redirect_to :action => :editar , :servico_id => @servico.id
		else
			flash[:error] = "Alterações não realizadas!"
			render(:action => "editar")
		end
	end

	def status
		if params[:acao] == "ina"
			acao = true
			msg = "Servico destvado com sucesso!"
		elsif params[:acao] == "atv"
			acao = false
			msg = "Servico ativado com sucesso!"
		end
		status = Servico.where("id = ?" , params[:servico_id])[0]
		status.update_attributes(:status => acao)
		flash[:notice] = "#{msg}"
		redirect_to :action => :index
	end

	private
		def servicos_params
			params.require(:servico).permit(:nome , :descricao , :preco)
		end
end