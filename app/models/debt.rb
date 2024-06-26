# app/models/debt.rb
class Debt < ApplicationRecord
  belongs_to :person

  after_save :update_person_balance
  after_destroy :update_person_balance

  private

  def update_person_balance
    person.update_balance_cache
  end
end
