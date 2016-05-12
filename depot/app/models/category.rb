class Category < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: true
	has_many :sub_categories,dependent: :destroy
	accepts_nested_attributes_for :sub_categories
=begin
	def self.get_all_category
		@records = $redis.get('all_category')
		if @records.blank?
			@records = Category.all.json
			LocalCahce.set('all_category', @records)
		end
		return @records
	end
=end
end
