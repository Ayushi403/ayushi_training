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
   # Cart.find(session[:cart_id])
  #rescue ActiveRecord::RecordNotFound
  if !current_user.cart.present?
      cart = Cart.create(:user_id => current_user.id)
   else
    cart = Cart.find(current_user.cart.id)
   end
    #cart = Cart.create
    cart
  end

  def after_sign_in_path_for(resource)
    resource.role?(:admin) ? products_path : super
  end

  # def current_user
  #  # binding.pry
  # # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def current_cart
  #  current_user.current_cart if current_user.present?
  # end
end
