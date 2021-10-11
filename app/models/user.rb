class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
