class User < ApplicationRecord
  has_many :enrollments, dependent: :restrict_with_error
  has_many :lessons, dependent: :restrict_with_error
  has_many :attendances, dependent: :restrict_with_error
  has_many :courses, dependent: :restrict_with_error
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :trackable, :lockable, :invitable
  
  include Roleable
  
  before_create :skip

  def skip
    self.skip_confirmation!
  end

  after_create do
    # assign default role
    self.update(student: true)
  end

  def to_s
    email
  end

  def to_label
    to_s
  end
  
end
