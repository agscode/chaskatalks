class Ticket < ApplicationRecord
  scope :by_date, ->(start_date, end_date) { 
    return if start_date.blank? || end_date.blank?

    where(capture_date: Time.strptime(start_date, '%m-%d-%Y')..Time.strptime(end_date, '%m-%d-%Y'))
  }
  scope :current_month, ->{ 
    beginning_of_month = Time.current.beginning_of_month
    end_of_month       = Time.current.end_of_month
    where(capture_date: beginning_of_month..end_of_month)
  }
  scope :yearly, ->(year) {
    date = Time.strptime("01-01-#{year}")
    where(capture_date: date.beginning_of_year..date.end_of_year)
  }

  scope :today, -> { where(capture_date: Date.current) }
  scope :yesterday, -> { where(capture_date: Date.yesterday) }
end

class Order < ApplicationController
  scope :by_date, ->(start_date, end_date) { 
    return if start_date.blank? || end_date.blank?

    where(capture_date: Time.strptime(start_date, '%m-%d-%Y')..Time.strptime(end_date, '%m-%d-%Y'))
  }
  scope :current_month, ->{ 
    beginning_of_month = Time.current.beginning_of_month
    end_of_month       = Time.current.end_of_month
    where(capture_date: beginning_of_month..end_of_month)
  }
  scope :yearly, ->(year) {
    date = Time.strptime("01-01-#{year}")
    where(capture_date: date.beginning_of_year..date.end_of_year)
  }
end

tickets = Ticket.current_month

class TicketController < ApplicationController
  def index
    @tickets = Ticket.all.by_date(params[:start_date], params[:end_date]).page(params[:page])
  end
end

class ApplicationController < ActionController::Base

end
