# frozen_string_literal: true
class TimeRange
  extend TimeConverter

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date   = end_date
  end

  attr_reader :start_date, :end_date

  def valid?
    start_date.present? && end_date.present?
  end

  def range
    format_date(start_date)..format_date(end_date).end_of_day
  end

  private

  def format_date(date)
    case date.class.to_s
    when 'String'
      Time.strptime(date, '%m-%d-%Y')
    when 'Date'
      date.to_time
    when 'Time', 'DateTime'
      date
    else
      raise 'NotSupported'
    end
  end
end
