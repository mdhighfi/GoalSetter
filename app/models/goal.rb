class Goal < ActiveRecord::Base
  validates :content, :private, :completed, :user_id, presence: true
  validates :private, :completed, inclusion: [true, false]

  belongs_to :user
end
