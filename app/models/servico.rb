class Servico < ActiveRecord::Base

	validate :validate

	def validate
		if new_record?
			errors.add(:base , 'Nome é obrigatório') if self.nome.blank?
			errors.add(:base , 'O servico já existe na base') if Servico.exists?(:nome => "#{self.nome}")
		end
	end

end