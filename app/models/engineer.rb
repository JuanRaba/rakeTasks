class Engineer < ApplicationRecord
  validates :idorigin, uniqueness: true

  has_many :jobs
end
