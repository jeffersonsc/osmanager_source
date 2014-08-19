class MenuController < ApplicationController
	before_filter :authorize
	def index
		@chamados_aberto = Chamado.where(:status => false).count
	end
end