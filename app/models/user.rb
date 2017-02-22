class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborators
  has_many :collaborating_on, through: :collaborators, source: :wiki
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]

  validates :email, length: { minimum: 3 }
  validates :username, presence: true, length: { minimum: 1, maximum: 20 }, uniqueness: true
end
