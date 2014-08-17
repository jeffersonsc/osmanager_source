class MenuController < ApplicationController
	def index
		@chamados_aberto = Chamado.where(:status => false).count
	end
end