class ApplicationController < ActionController::Base
  protect_from_forgery
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
