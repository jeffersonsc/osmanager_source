class Cliente < ActiveRecord::Base

	validate :validate

	def validate
		if self.tp_cliente == true
			errors.add(:base , 'Nome é obrigatório') if self.nome.blank?
		  errors.add(:base , 'Sexo é obrigatório') if self.sexo.blank?
		  errors.add(:base , 'A datade nascimento é obrigatório') if self.dt_nascimento.blank?
			errors.add(:base , 'RG é obrigatório') if self.rg.blank?
			errors.add(:base , 'SSP é obrigatório') if self.ssp.blank?
			errors.add(:base , 'CPF é obrigatório') if self.cpf.blank?
			errors.add(:base , 'CEP é obrigatório') if self.cep.blank?
			errors.add(:base , 'RG é obrigatório') if self.rg.blank?
			errors.add(:base , 'CPF é obrigatório') if self.cpf.blank?
			errors.add(:base , 'Local de nascimento precisa ser preenchido') if self.naturalidade.blank?
		else
			errors.add(:base , 'A razão social não pode ficar em branco') if self.rz_social.blank?
			errors.add(:base , 'CNPJ é obrigatório') if self.cnpj.blank?
			errors.add(:base , 'Inscrição social é obrigatório') if self.ie.blank?
			errors.add(:base , 'Nome de responsável é obrigatório') if self.nome_responsavel.blank?
		end
		errors.add(:base , 'Endereço é obrigatório') if self.endereco.blank?
		errors.add(:base , 'Número é obrigatório') if self.cep.blank?
		errors.add(:base , 'Bairro é obrigatório') if self.bairro.blank?
		errors.add(:base , 'Cidade é obrigatório') if self.cidade.blank?
		errors.add(:base , 'Estado é obrigatório') if self.estado.blank?
		errors.add(:base , 'Telefone 1 é obrigatório') if self.telefone1.blank?
	end

end