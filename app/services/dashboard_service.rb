class DashboardService
    def initialize(user)
      @user = user
    end
  
    def dashboard_data
      Rails.cache.fetch(cache_key, expires_in: 30.seconds) do
        {
          active_people_pie_chart: active_people_pie_chart,
          total_debts: total_debts,
          total_payments: total_payments,
          balance: balance,
          last_debts: last_debts,
          last_payments: last_payments,
          my_people: my_people,
          top_person: top_person,
          bottom_person: bottom_person
        }
      end
    end
  
    private
  
    attr_reader :user
  
    def cache_key
      "dashboard/#{user.id}/#{user.updated_at}"
    end
  
    def active_people_pie_chart
      {
        active: Person.where(active: true).count,
        inactive: Person.where(active: false).count
      }
    end
  
    def total_debts
      Debt.joins(:person).where(people: { active: true }).sum(:amount)
    end
  
    def total_payments
      Payment.joins(:person).where(people: { active: true }).sum(:amount)
    end
  
    def balance
      total_payments - total_debts
    end
  
    def last_debts
      Debt.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  
    def last_payments
      Payment.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  
    def my_people
      Person.where(user: user).order(created_at: :desc).limit(10)
    end
  
    def top_person
        Person.all.max_by do |person|
          person.balance
        end
    end
      
    def bottom_person
        Person.all.min_by do |person|
            person.balance
        end
    end
  end
  