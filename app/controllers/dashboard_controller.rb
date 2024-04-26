class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    dashboard_service = DashboardService.new(current_user)
    data = dashboard_service.dashboard_data

    @active_people_pie_chart = data[:active_people_pie_chart]
    @total_debts = data[:total_debts]
    @total_payments = data[:total_payments]
    @balance = data[:balance]
    @last_debts = data[:last_debts]
    @last_payments = data[:last_payments]
    @my_people = data[:my_people]
    @top_person = data[:top_person]
    @bottom_person = data[:bottom_person]
  end
end
