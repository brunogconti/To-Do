class Record < ApplicationRecord
  belongs_to :task
  validates :task, presence: true
end
