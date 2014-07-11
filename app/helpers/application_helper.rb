module ApplicationHelper
	def cliente(value)
		if value == true
			("Pessoa Fisíca")
		else
			("Pessoa Jurídica")
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
end
