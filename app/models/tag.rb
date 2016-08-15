class Tag < ActiveRecord::Base
	##Associations
	has_and_belongs_to_many :questions

	##Validations
	validates :name, presence: true, uniqueness: true

	def self.newest
		Tag.order(created_at: :desc)
	end

	def self.search(name)
		Tag.where("name LIKE ?", "%#{name}%")
	end

end
