# -*- coding: utf-8 -*-

class Row
  attr_accessor :name, :gene

  def initialize(name, days, shift)
    @name   = name

    gene = ""
    days.length.times do
      gene << rand(shift.min..shift.max).to_s
    end
    @gene   = gene
  end

  def mutate
    @gene[rand(0..@gene.length-1)] = rand(0..3).to_s
  end

end
