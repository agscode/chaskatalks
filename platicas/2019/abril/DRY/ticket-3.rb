class Ticket < ApplicationRecord
  include Dateable
end

class Order < ApplicationController
  include Dateable
end

class Claim < ApplicationController
  scope :by_date_range, ->(date_range) { 
    where(created_at: date_range.range) if date_range.valid?
  }
  scope :current_month, ->{
    date_range = DateRange.new(Time.current.beginning_of_month, Time.current.end_of_month)
    by_date(date_range)
  }
  scope :yearly, ->(year) {
    date = Date.parse("01-01-#{year}")
    date_range = DateRange.new(date.beginning_of_year, date.end_of_year)
    by_date(date_range)
  }
end
