module Dateable
  extend ActiveSupport::Concern
  DEFAULT_COLUMN_NAME = 'capture_at'
  included do
    scope :by_date, ->(date_range, field = dateable_column) {
      where(field => date_range.range) if date_range.valid?
    }
    scope :yearly, ->(year) {
      date = Time.parse("01-01-#{year}")
      date_range = DateRange.new(date.beginning_of_year, date.end_of_year)
      by_date(date_range)
    }
    scope :month, -> {
      date_range = DateRange.new(Date.current.beginning_of_month, Date.current.end_of_month)
      by_date(date_range)
    }
    scope :of_the_week, ->(time = Time.now, field = dateable_column) {
      date_range = DateRange.new(time.at_beginning_of_week, time.end_of_week)
      by_date(date_range, field)
    }
    scope :yesterday, -> {
      time = Time.now - 1.day
      date_range = DateRange.new(time.at_beginning_of_day, time.end_of_day)
      by_date(date_range)
    }
    scope :today, ->{
      time = Time.now
      date_range = DateRange.new(time.at_beginning_of_day, time.end_of_day)
      by_date(date_range)
    }

    module ClassMethods
      def dateable_column
        self::DATEABLE_COLUMN_NAME || DEFAULT_COLUMN_NAME
      end
    end
  end
end

Ticket.by_date(date_range,'updated_at')
