class ChamadosController < ApplicationController
	before_filter :authorize
	def index
		@cliente = Cliente.buscar(params[:busca_cliente]).paginate(:page => params[:page] , :per_page => 10).order("id")

		sql = "
			SELECT
				clientes.nome AS cliente_nome,
				servicos.nome AS servico_nome,
				chamados.id,
				chamados.funcionario_id,
				chamados.atribuido_para,
				chamados.agendamento,
				chamados.hora_saida,
				chamados.status,
				chamados.created_at
			FROM
				chamados
				INNER JOIN clientes ON (clientes.id = chamados.cliente_id)
				INNER JOIN servicos ON (servicos.id = chamados.servico_id)
			ORDER BY
				chamados.id"				
		@chamados = Chamado.find_by_sql(sql)
	end

	def add_chamado
		@chamado = Chamado.new
		@servico = Servico.where("status = ?", false)
		@funcionario = Funcionario.all
		@cliente = Cliente.where("id = ?", params[:cliente_id])
		if @cliente[0].status == true or @cliente[0].inativo == true
			flash[:error] = "O cliente está bloqueado ou inativado para chamados!"
			redirect_to(:action => :index)
		end
	end

	def create
		@chamado = Chamado.new
		@chamado.cliente_id = params[:chamado][:cliente_id] if params[:chamado][:cliente_id]
		@chamado.servico_id = params[:chamado][:servico_id] if params[:chamado][:servico_id]
		@chamado.funcionario_id = @current_user.id
		@chamado.atribuido_para = params[:chamado][:atribuido_para] if params[:chamado][:atribuido_para]
		@chamado.descricao = params[:chamado][:descricao] if params[:chamado][:descricao]
		@chamado.agendamento = params[:chamado][:agendamento] if params[:chamado][:agendamento]
		if params[:chamado][:agendamento] == true
			@chamado.hora_saida = params[:chamado][:hora_saida] if params[:chamado][:hora_saida]
		end
		@chamado.solicitante = params[:chamado][:solicitante] if params[:chamado][:solicitante]
		@chamado.tel_contato = params[:chamado][:tel_contato] if params[:chamado][:tel_contato]

		if @chamado.save
			flash[:notice] = "Chamado criado com sucesso!"
			redirect_to(:action => "detalhes" , :chamado_id => @chamado.id)
		else
			render(:action => "add_chamado")
		end
	end

	def detalhes
		@funcionarios = Funcionario.all
		@chamado = Chamado.where("id = ?", params[:chamado_id])[0]
		@cliente = Cliente.where("id = ?", @chamado.cliente_id)
		@servico = Servico.where("id = ?", @chamado.servico_id)
		@historico_chamados = HistoricoChamado.where("chamado_id = ?", @chamado.id)
		@historico = HistoricoChamado.new

		puts "=========================== chamado controller ======================"
		puts @funcionarios.map{|fun| [fun.nome , fun.id] }
	end

	def atualizar_chamado
		if params[:status] == "true"
			chamado = HistoricoChamado.create(:chamado_id => params[:chamado_id] , :funcionario_id => 1 , :historico => params[:historico])
			chamado = HistoricoChamado.create(:chamado_id => params[:chamado_id] , :funcionario_id => 1 , :historico => "O chamado foi encerrado ")
			chamado = Chamado.where("id = ?", params[:chamado_id])
			chamado.update_attributes(:status => true)
			flash[:notice] = "Chamado Encerrado com sucesso"
			redirect_to(:action => :index)
		else
			#chamados = HistoricoChamado.create(:chamado_id => params[:chamado_id] , :funcionario_id => 1 , :historico => params[:historico_chamados][:historico])
			#flash[:notice] = "Chamado Encerrado com sucesso"
			#redirect_to(:action => :detalhes , :chamado_id => chamados.chamado_id)
		puts "================== CHAMADO ======================"
		puts params[:chamado_id]
		puts params[:cliente_id]
		puts params[:atribuido_para]
		puts params[:status]
		puts params[:historico]
		puts "================================================="

		redirect_to :back
		end
	end

	private
		def chamado_params
			if params[:chamado][:agendamento] == false
				params.require(:chamado).permit(:cliente_id , :servico_id , :atribuido_para , :descricao , :funcionario_id)
			else  
				params.require(:chamado).permit(:cliente_id , :servico_id , :atribuido_para , :descricao , :agendamento , :hora_saida , :funcionario_id)
			end
		end
end