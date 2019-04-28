class Job < ApplicationRecord
  #???? validates :employer + :engineer, uniqueness: true

  belongs_to :engineer
end
