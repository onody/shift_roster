# -*- coding: utf-8 -*-
require 'active_support'
require 'active_support/core_ext'
require 'holiday_jp'

class Days

  def set_days(year, month)
    @year = year
    @month= month
    time  = Time.mktime year, month
    @days = [*(1..time.at_end_of_month.day)]
  end

  def set_holidays
    holidays = []

    @days.each do |date|
      this_day = Time.mktime @year, @month, date
      holidays << date if this_day.sunday? || this_day.saturday? || HolidayJp.holiday?(Date.new(@year,@month,date))
    end
    return holidays
  end

end