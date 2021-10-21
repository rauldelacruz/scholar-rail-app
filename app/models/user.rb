class User < ApplicationRecord
  has_many :enrollments, dependent: :restrict_with_error
  has_many :lessons, dependent: :restrict_with_error
  has_many :attendances, dependent: :restrict_with_error
  has_many :courses, dependent: :restrict_with_error
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :trackable, :lockable, :invitable
  
  include Roleable

  monetize :student_total, as: :student_total_cents
  
  before_create :skip

  def skip
    self.skip_confirmation!
  end

  after_touch do
    calculate_student_total
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

  private

  def calculate_student_total
    update_column :student_total, attendances.map(&:student_price_final).sum
  end
  
end
