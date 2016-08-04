class Tag < ActiveRecord::Base
	##Associations
	has_and_belongs_to_many :questions

	##Validations
	validates :name, presence: true, uniqueness: true

end
