class ApplicationController < ActionController::Base
  #load_and_authorize_resource
  before_filter :authenticate_user!
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
  #flash[:error] = "Access denied!"
  redirect_to '/'
end

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def after_sign_in_path_for(resource)
    resource.role?(:admin) ? products_path : super
    end
end
