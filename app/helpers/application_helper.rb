module ApplicationHelper
	def cliente(value)
		if value == true
			("Pessoa Fisíca")
		else
			("Pessoa Jurídica")
		end
	end

	def sexo(value)
		if value == "m"
			return "Masculino"
		else
			return "Feminino"
		end
	end

	def situacao(value)
		if value == false
			"Ativo"
		else
			"Inativado"
		end
	end

	def status(value)
		if value == false
			"Ativo"
		else
			"Bloqueado"
		end
	end

	def datetime(datetime)
		datetime.strftime("%d/%m/%Y - %H:%M")
	end

	def date(date)
		date.strftime("%d/%m/%Y")
	end

	def time(time)
		time.strftime("%H:%M")
	end

	def situacao_contrato(value)
		if value == "cotacao"
			return "Cotação"
		elsif value == "aberto"
			return "Aberto"
		elsif value == "cancelado"
			return "Cancelado"
		end
	end

	def funcionario(value)
		@funcionario = Funcionario.where("id = ?", value)[0]
		if not @funcionario.nil?
			return "#{@funcionario.nome}"
		end
	end

	def status_chamado(status , atribuido , agendamento , saida)
		if status == false and atribuido.nil? and agendamento == false
			return "Aberto"
		elsif status == true 
			return "Fechado"
		elsif not saida.nil? and not atribuido.nil? and agendamento == false
			return "Em atendimento"
		elsif saida.nil? and not atribuido.nil? and agendamento == false
			return "Não saiu"
		elsif agendamento == true and status == false and not saida.nil?
			return "Agendado"
		end		
	end

	def situacao_chamado(value)
		if value == true 
			return "Fechado"
		else
			return "Aberto"
		end
	end

	def color(status , atribuido , agendamento , saida)
		if status == false and atribuido.nil? and saida.nil? and agendamento == false
			return "#FE2E2E" #cor para chamados abertos vermelho
		elsif status == true
			return "#00FF00" #cor para chamados fechados verde
		elsif not atribuido.nil? and agendamento == false
			return "#F7FE2E" #cor para chamados em atendimento 
		elsif status == false and agendamento == true and saida < Time.now
			return "#8904B1" #cor para os agendada caso a saida seja menor  igual que data atual
		elsif status == false and agendamento == true and saida > Time.now
			return "#5882FA" #cor para agendamento que ultrapassou 
		end		
	end
end
