class ApplicationController < ActionController::Base
  
  #helper_method :current_user
  #before_filter :current_user

  #adiciona globalmente informações do usuário que está logado  
  helper_method :current_user
  private

  def current_user
    puts "==========="
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end
end
