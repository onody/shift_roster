# -*- coding: utf-8 -*-

class Samples
  attr_accessor :data

  def initialize(days, members, shift)
    @data  = []
    10.times do
      @data << Sample.new(members, days, shift)
    end
  end

  def evaluate(days,holidays)
    @data.each do |sample|
      sample.evaluate(days,holidays)
    end

    # sort
    @data = @data.sort { |aa,bb|
      bb.point <=> aa.point
    }
  end

  def alternate

    # 親を交叉し、子ども作成
    children    = []
    children[0] = @data[0].clone
    children[1] = @data[0].clone
    children[0].data[3..5] = @data[1].data[3..5]
    children[1].data[3..5] = @data[0].data[3..5]

    # 子どもの突然変異
    children[1].data[4].mutate

    # 二つ落として、子ども2人を追加
    @data.pop(2)
    @data.concat(children)

    # ポイントリセット
    @data.each do |sample|
      sample.point = 0
    end

  end

end