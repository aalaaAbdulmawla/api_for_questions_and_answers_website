class User < ActiveRecord::Base
  ##Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        # :confirmable, :lockable, :timeoutable 

  ##Associations
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :favorite_questions
  has_many :favorites, through: :favorite_questions, source: :question

  ##validations
  validates :first_name, :last_name, length: { maximum: 30}
  validates :location, :job, length: { maximum: 65}
  validates :about, length: { maximum: 500}

  validates_format_of :birth_date, :with => /\d{4}\-\d{2}\-\d{2}/, 
  :message => "Birth date must be in the following format: yyyy/mm/dd"

  validate :age_must_be_greater_than_ten

  def age_must_be_greater_than_ten
    if birth_date.present? && birth_date + 10 >= Date.today
      errors.add(:age, "can't be less than ten.")
    end
  end    

end
