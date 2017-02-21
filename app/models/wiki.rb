class Wiki < ActiveRecord::Base
  belongs_to :user
  after_save :confirm_private_valid

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 20 }

  def confirm_private_valid
    if user.standard? && private
      update_attribute(:private, false)
    end
  end
end
