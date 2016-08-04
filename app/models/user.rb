class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        # :confirmable, :lockable, :timeoutable 


  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :favorite_questions # just the 'relationships'
  has_many :favorites, through: :favorite_questions, source: :question
end
