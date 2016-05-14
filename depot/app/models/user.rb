class User < ActiveRecord::Base
	before_create :set_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :roleusers
  has_many :roles, :through => :roleusers

  has_one :cart

  # def current_cart
  #   if !self.cart.present?
  #     cart = Cart.create
  #   end
  #   cart
  # end

  def set_role 
  	  customer_role = Role.find_by_name('customer')
  	  self.roles << customer_role
   end

   def role?(*roles)
    @role_names ||= self.roles.select(:name).map(&:name)
    (@role_names & roles.map(&:to_s)).present?
  end
end
