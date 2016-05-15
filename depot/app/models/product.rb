class Product < ActiveRecord::Base
validates :title, :description, :image_url, presence: true
#validates :title, :description, presence: true
validates :price, numericality: {greater_than_or_equal_to: 0.01}
validates :title, uniqueness: true
# validates :image_url, format: {
# with:
# %r{\.(gif|jpg|png)$}i,
# message: 'must be a URL for GIF, JPG or PNG image.'
# }
has_many :line_items
has_many :orders, through: :line_items
before_destroy :ensure_not_referenced_by_any_line_item
belongs_to :sub_category

after_commit :proucts_delayed_job, on: :create
# after_commit :proucts_delayed_job, on: :update
mount_uploader :image_url, AvatarUploader
private

# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
	if line_items.empty?
		return true
	else
		errors.add(:base, 'Line Items present')
		return false
	end
end



def self.get_all_category
	@records = $redis.get('all_category')
	 if @records.blank?
		# @all_records = Product.joins(sub_category: :category)
		@all_records = Product.joins(sub_category: :category).select("products.*,sub_categories.name as sub_name, categories.id as cat_id")
		
		$redis.set('all_category', @all_records.to_json)
	 end
	return @records
end

def refresh_data_after_commit
	prod_records = Product.joins(sub_category: :category).select("products.*,sub_categories.name as sub_name, categories.id as cat_id")
	$redis.set('all_category', prod_records.to_json)

	return @records
end

def proucts_delayed_job
    delay.refresh_data_after_commit
    # create_notifications
  end

end

