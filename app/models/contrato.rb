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
end