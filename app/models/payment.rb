class Payment < ApplicationRecord
  belongs_to :person

  after_save :update_person_balance
  after_destroy :update_person_balance

  def update_person_balance
    person.clear_balance_cache
  end
end
