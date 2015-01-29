# -*- coding: utf-8 -*-
require './days.rb'
require './samples/samples.rb'
require './samples/sample.rb'
require './samples/row.rb'

require 'kosi'

class ShiftRoster

  def initialize(year, month)
    days      = Days.new
    @days     = days.set_days(year, month)
    @holidays = days.set_holidays
    @members  = ['A', 'B', 'C', 'D', 'E', 'F']
    @shift    = [*(0..3)] # 0:休み 1:早番 2:遅番 3:フル番
    @year     = year
    @month    = month
  end

  def execute
    samples   = Samples.new(@days, @members, @shift)

    1000.times do
      samples.evaluate(@days, @holidays)
      samples.alternate
    end

    samples.evaluate(@days, @holidays)
    table_view(samples.data[0])

  end

  def table_view(sample)
    kosi = Kosi::Table.new({separate_each_row: true})

    rows = []

    head = []
    head << "#{@year}年#{@month}月"
    head.concat(@days)

    rows << head

    sample.data.each do |val|
      tmp = []
      tmp << val.name
      tmp.concat(val.gene.split(""))
      rows << tmp
    end

    print kosi.render(rows)

  end

end


shift = ShiftRoster.new(2014,2)
shift.execute


