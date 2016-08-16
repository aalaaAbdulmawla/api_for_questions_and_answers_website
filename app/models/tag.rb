class Tag < ActiveRecord::Base
	##Associations
	has_and_belongs_to_many :questions

	##Validations
	validates :name, presence: true, uniqueness: true

	##Scopes
	scope :popular, -> {
    select("tags.id, count(questions.id) AS questions_count").
    joins(:questions).
    group("tags.id").
    order("questions_count DESC").
    limit(5)
  }

  ##Class methods
	def self.newest
		Tag.order(created_at: :desc)
	end

	def self.search(name)
		Tag.where("name LIKE ?", "%#{name}%")
	end


end
