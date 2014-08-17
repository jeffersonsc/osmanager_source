class CargosController < ApplicationController
	def index
		@cargo = Cargo.all
	end

	def add
		@cargo = Cargo.new
	end

	def create
		@cargo = Cargo.new(params_cargo)
		if @cargo.save
			flash[:notice] = "Cargo criado com sucesso!"
			redirect_to :controller => "contratos" , :action => "index"
		else
			render(:action => :new)
			flash[:error] = "Cargo não criado"
		end
	end

	def editar
		@cargo = Cargo.where("id = ?" , params[:cargo_id])[0]	
	end

	def update
		@cargo = Cargo.where("id = ?" , params[:cargo_id])[0]
		@cargo.update_attributes(params_cargo)
		if @cargo.save
			flash[:notice] = "Cargo alterado com sucesso!"
			redirect_to :controller => "cargos" , :action => "index"
		else
			render(:action => :editar)
			flash[:error] = "Cargo não alterado!"
		end		
	end

	def status
		cargo = Cargo.where("id = ?" , params[:cargo_id])[0]
		cargo.update_attributes(:status => params[:acao])
		flash[:notice] = "Cargo alterado com sucesso!"
		redirect_to :action => "index"
	end

	private
		def params_cargo
			params.require(:cargo).permit(:nome , :descricao )
		end
end