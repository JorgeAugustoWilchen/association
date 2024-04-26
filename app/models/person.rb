class Person < ApplicationRecord
  belongs_to :user, optional: true
  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  after_save :clear_balance_cache
  after_destroy :clear_balance_cache

  def balance
    Rails.cache.fetch "balance_#{id}" do
      payments.sum(:amount) - debts.sum(:amount)
    end
  end

  def update_balance_cache
    Rails.cache.write("balance_#{id}", total_payments - total_debts)
  end

  def clear_balance_cache
    Rails.cache.delete "balance_#{id}"
  end

  private

  def total_debts
    debts.sum(:amount)
  end

  def total_payments
    payments.sum(:amount)
  end

  def cpf_or_cnpj
    unless CPF.valid?(national_id) || CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end
