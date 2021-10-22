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
  monetize :teacher_total, as: :teacher_total_cents
  monetize :balance, as: :balance_cents
  
  before_create :skip

  def skip
    self.skip_confirmation!
  end

  after_touch do
    calculate_student_total
    calculate_teacher_total
    calculate_balance
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

  def calculate_teacher_total
    update_column :teacher_total, lessons.map(&:teacher_price_final).sum
  end

  def calculate_balance
    update_column :balance, (teacher_total - student_total)
  end
  
end
