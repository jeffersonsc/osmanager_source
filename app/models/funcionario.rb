class Funcionario < ActiveRecord::Base

	validate :validate

	def self.buscar(value , page)
		if value.nil?
			sql = "
				SELECT
					funcionarios.id,
					funcionarios.nome,
					funcionarios.dt_admissao,
					cargos.nome AS cargo_nome,
					funcionarios.status,
					funcionarios.updated_at
				FROM
					funcionarios
					INNER JOIN cargos ON (cargos.id = funcionarios.cargo_id)
				ORDER BY
					funcionarios.id"
			paginate_by_sql(sql, :page => page, :per_page => 20)
		else
			sql = "
				SELECT
					funcionarios.id,
					funcionarios.nome,
					funcionarios.dt_admissao,
					cargos.nome AS cargo_nome,
					funcionarios.status,
					funcionarios.updated_at
				FROM
					funcionarios
					INNER JOIN cargos ON (cargos.id = funcionarios.cargo_id)
				WHERE
					nome ILIKE '%#{value}%'
				ORDER BY
					funcionarios.id"
			paginate_by_sql(sql, :page => page, :per_page => 20)
		end
	end

	def validate
		if new_record?
			errors.add(:base , 'Nome é obrigatório') if self.nome.blank?
		  errors.add(:base , 'Sexo é obrigatório') if self.sexo.blank?
		  errors.add(:base , 'A datade nascimento é obrigatório') if self.dt_nascimento.blank?
			errors.add(:base , 'RG é obrigatório') if self.rg.blank?
			errors.add(:base , 'O RG já existe na base') if Cliente.exists?(:rg => self.rg)
			errors.add(:base , 'SSP é obrigatório') if self.ssp.blank?
			errors.add(:base , 'CPF é obrigatório') if self.cpf.blank?
			errors.add(:base , 'O Cpf já existe na base') if Cliente.exists?(:cpf => self.cpf)
			errors.add(:base , 'CEP é obrigatório') if self.cep.blank?
			errors.add(:base , 'RG é obrigatório') if self.rg.blank?
			errors.add(:base , 'CPF é obrigatório') if self.cpf.blank?
			errors.add(:base , 'Local de nascimento precisa ser preenchido') if self.naturalidade.blank?
			errors.add(:base , 'Endereço é obrigatório') if self.endereco.blank?
			errors.add(:base , 'Número é obrigatório') if self.cep.blank?
			errors.add(:base , 'Bairro é obrigatório') if self.bairro.blank?
			errors.add(:base , 'Cidade é obrigatório') if self.cidade.blank?
			errors.add(:base , 'Estado é obrigatório') if self.estado.blank?
			errors.add(:base , 'Telefone 1 é obrigatório') if self.telefone1.blank?
		end
	end

end