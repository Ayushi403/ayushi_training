class Category < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: true
	has_many :sub_categories,dependent: :destroy
	accepts_nested_attributes_for :sub_categories
end
