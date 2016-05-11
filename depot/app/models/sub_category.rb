class SubCategory < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: true
	belongs_to :category	
	has_many :products, dependent: :destroy
end
