class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, length: { minimum: 3 }
  validates :username, presence: true, length: { minimum: 1, maximum: 20 }, uniqueness: true
end
