class ApplicationController < ActionController::Base
  
  #helper_method :current_user
  before_filter :current_user

  #adiciona globalmente informações do usuário que está logado  
  #helper_method :current_user
  
  private

  def authorize
    puts @current_user
  	if session[:usuario_id].blank?
  		flash[:error] = "Voce não está logado"
  		redirect_to root_url
  	end
  end

  def current_user
    @current_user ||= Funcionario.where("id = ?" , session[:usuario_id])[0] if session[:usuario_id]
  end
end
