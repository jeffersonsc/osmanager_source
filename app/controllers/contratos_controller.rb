class ContratosController < ApplicationController

	def index
		sql = "SELECT
						contratos.id,
						clientes.nome AS cliente_nome,
						tipos_contrato.nome AS tp_contrato_nome,
						contratos.situacao,
						contratos.status,
						contratos.validade

					FROM
						contratos
						INNER JOIN clientes ON ( clientes.id = contratos.cliente_id )
						INNER JOIN tipos_contrato ON ( tipos_contrato.id = contratos.tipos_contrato_id )
					ORDER BY
						contratos.id
					"
		@contratos = Contrato.find_by_sql(sql)
	end

	def add
		@contrato = Contrato.new
		@cliente = Cliente.where("status = ? AND inativo = ?", false , false)
		@tp_contrato = TipoContrato.where("status = ?", false)
	end

	def add_contrato
		if params[:contrato][:contrato_file].blank?
			flash[:error] = "Precisa do arquivo do contrato para importação"
			redirect_to :back
		else
			path = "#{Rails.root}/tmp/#{params[:contrato][:contrato_file].original_filename}"
			file = File.open(path , "wb") {|f| f.write(params[:contrato][:contrato_file].read)}
			type = params[:contrato][:contrato_file].content_type
			filename = params[:contrato][:contrato_file].original_filename
			@contrato = Contrato.new(contrato_params)
			if @contrato.save
				flash[:notice] = "Contrato criado com sucesso!"
				redirect_to :action => :index
				system("ruby #{Rails.root}/lib/upload_contratos.rb #{@contrato.id} #{path} #{type} #{filename}")
			else
				@cliente = Cliente.where("status = ? AND inativo = ?", false , false)
				@tp_contrato = TipoContrato.where("status = ?", false)
				flash[:error] = "Contrato não criado!"
				render(:action => "add")
				system("rm -rf #{path} ")
			end
		end
	end

	def editar
		@contrato = Contrato.where("id = ?", params[:contrato_id])
	end

	private
		def contrato_params
			params.require(:contrato).permit(:cliente_id , :tipos_contrato_id , :valor , :validade , :descricao)
		end
end