class Contrato < ActiveRecord::Base

	validate :validate

	def validate
		if new_record?
			errors.add(:base , 'O cliente não pode ficar em branco') if self.cliente_id.blank?
			errors.add(:base , 'O tipo de contrato não pode ficar em branco') if self.tipos_contrato_id.blank?
			errors.add(:base , 'O cliente já possui esté contrato') if Contrato.where("cliente_id = ? AND tipos_contrato_id = ?", self.cliente_id , self.tipos_contrato_id).exists?
			errors.add(:base , 'O valor do contrato não pode ficar em branco') if self.valor.blank?
			errors.add(:base , 'A validade contrato não pode ficar em branco') if self.tipos_contrato_id.blank?
		end
	end

	def self.buscar(busca , page)
		if busca.nil?
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
					WHERE
						contratos.status = false
					ORDER BY
						contratos.id
					"
			paginate_by_sql(sql, :page => page, :per_page => 20)

		else
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
					WHERE
						contratos.id::text ILIKE '%#{busca}%'
						OR clientes.nome ILIKE '%#{busca}%'
						OR tipos_contrato.nome ILIKE '%#{busca}%'
						AND contratos.status = false
					ORDER BY
						contratos.id
					"
			paginate_by_sql(sql, :page => page, :per_page => 20)
		end
	end

end