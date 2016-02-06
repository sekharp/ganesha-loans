class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :amount, presence: true
end
