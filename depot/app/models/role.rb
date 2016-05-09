class Role < ActiveRecord::Base
	has_many :roleusers
	has_many :users, :through => :roleusers
end
