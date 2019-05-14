class Ticket < ApplicationRecord
  scope :by_date_range, ->(date_range) { 
    where(capture_date: date_range.range) if date_range.valid?
  }
  scope :current_month, ->{
    date_range = DateRange.new(Time.current.beginning_of_month, Time.current.end_of_month)
    by_date_range(date_range)
  }
  scope :yearly, ->(year) {
    date = Date.parse("01-01-#{year}")
    date_range = DateRange.new(date.beginning_of_year, date.end_of_year)
    by_date_range(date_range)
  }

  scope :today, -> { where(capture_date: Date.current) }
  scope :yesterday, -> { where(capture_date: Date.yesterday) }
end

class Order < ApplicationRecord
  scope :by_date_range, ->(date_range) { 
    where(capture_date: date_range.range) if date_range.valid?
  }
  scope :current_month, ->{
    date_range = DateRange.new(Time.current.beginning_of_month, Time.current.end_of_month)
    by_date_range(date_range)
  }
  scope :yearly, ->(year) {
    date = Date.parse("01-01-#{year}")
    date_range = DateRange.new(date.beginning_of_year, date.end_of_year)
    by_date_range(date_range)
  }
end

class TicketController < ApplicationController
  def index
    @tickets = Ticket.all.by_date_range(date_range_from_params)
  end
end

class ORderController < ApplicationController
  def index
    @order = Order.by_date_range(date_range_from_params)
  end
end

class ApplicationController < ActionController::Base
  def date_range_from_params
    DateRange.new(params[:start_date], params[:end_date])
  end
end

