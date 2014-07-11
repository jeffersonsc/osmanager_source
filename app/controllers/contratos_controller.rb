class ContratosController < ApplicationController

	def index
		@contratos = Contrato.buscar(params[:busca] , params[:page])
	end

	def add
		@contrato = Contrato.new
		@cliente = Cliente.where("status = ? AND inativo = ?", false , false)
		@tp_contrato = TipoContrato.where("status = ?", false)
		@tp_pagamento = TipoPagamentoContrato.all
	end

	def add_contrato
		@contrato = Contrato.new(contrato_params)
		if @contrato.save
			flash[:notice] = "Contrato criado com sucesso!"
			redirect_to :action => :index
		else
			@cliente = Cliente.where("status = ? AND inativo = ?", false , false)
			@tp_contrato = TipoContrato.where("status = ?", false)
			@tp_pagamento = TipoPagamentoContrato.all
			flash[:error] = "Contrato não criado!"
			render(:action => "add")
		end
	end

	def editar
		@contrato = Contrato.where("id = ?", params[:contrato_id])[0]
		@cliente = Cliente.where("id = ?", @contrato.cliente_id)
		@tp_contrato = TipoContrato.where("id = ?", @contrato.tipos_contrato_id)
		@tp_pagamento = TipoPagamentoContrato.where("id = ?", @contrato.tipo_pagamento_contrato_id)
		@contrato_file = Arquivo.where("contrato_id = ? AND status = ?", @contrato.id , false)
	end

	def update
		@contrato = Contrato.where("id = ?", params[:contrato_id])[0]
		@contrato.update_attributes(contrato_params)
		flash[:notice] = "Alterado com sucesso!"
		redirect_to(:action => "editar" , :contrato_id => @contrato.id)
	end

	def importar_contrato
		if params[:contrato_file].blank?
			flash[:error] = "Precisa do arquivo do contrato para importação"
			redirect_to :back
		else
			path = "#{Rails.root}/tmp/#{params[:contrato_file].original_filename}"
			file = File.open(path , "wb") {|f| f.write(params[:contrato_file].read)}
			type = params[:contrato_file].content_type
			filename = params[:contrato_file].original_filename
			redirect_to :back
			system("ruby #{Rails.root}/lib/upload_contratos.rb #{params[:contrato_id]} #{path} #{type} #{filename}")
		end
	end

	def download_contrato
		contrato_file = Arquivo.where("contrato_id = ? AND id = ?", params[:contrato_id], params[:file_id])[0]

		data = contrato_file.contrato_bin
		send_data( data , :filename => "#{contrato_file.filename}" )
	end

	def remover_contrato_file
		contrato_file = Arquivo.where("id = ? AND contrato_id = ?", params[:file_id] , params[:contrato_id])[0]
		contrato_file.update_attributes(:status => true)
		flash[:notice] = "Arquivo removido com sucesso"
		redirect_to :back
	end

	def situacao_contrato
		contrato = Contrato.where("id = ?", params[:contrato_id])[0]
		contrato.update_attributes(:situacao => params[:situacao])
		flash[:notice] = "Situação do contrato foi alterada!"
		redirect_to :back
	end

	def remove_contrato
		contrato = Contrato.where("id = ?", params[:contrato_id])[0]
		contrato.update_attributes(:status => true)
		flash[:notice] = "O contrato foi removido com sucesso!"
		redirect_to(:action => "index")
	end

	private
		def contrato_params
			params.require(:contrato).permit(:cliente_id , :tipo_pagamento_contrato_id , :tipos_contrato_id , :valor , :validade , :descricao)
		end
		def contrato_params_edit
			params.require(:contrato).permit(:valor , :descricao)
		end
end