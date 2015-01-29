# -*- coding: utf-8 -*-

class Sample
  attr_accessor :data, :point


  def initialize(members, days, shift)
    @point  = 0
    @data = []
    members.each do |val|
      @data << Row.new(val,days, shift)
    end
  end


  def evaluate(days, holidays)

    @point = 1000
    daily = {}
    days.each do |val|
      daily[val] = []
    end

    @data.each do |row|

      # | 理想の働いた日数点 - 働いた日数 | * -10
      @point += (((days.length - holidays.length) - (row.gene.length - row.gene.count("0"))).abs * -10)

      # 連勤点 1: -10  2:10 3:20 4:20  5:-10
      counter = row.gene.scan(/0(.*?)0/)
      counter.each do |count|
        case count[0].length
          when 1; @point += -10
          when 2; @point += 10
          when 3; @point += 20
          when 4; @point += 20
          when 5; @point += -10
        end
      end

      # 日付毎の配列生成
      days.each do |val|
        daily[val] << row.gene[val-1].to_i
      end

    end

    # シフトポイント計算
    daily.each do |key,val|

      if holidays.include?(key)
        # 土日・祝日

        # 5or6名体制でない
        if val.count(0) > 1
          @point += -50
        end

        # 5人が同じ時間帯
        if val.count(1) == 5 || val.count(2) == 5 || val.count(3) == 5
          @point += -30
        end

        # 4人が同じ時間帯
        if val.count(1) == 4 || val.count(2) == 4 || val.count(3) == 4
          @point += -20
        end

        if val.count(1) == 3 && val.count(2) == 3
          # 早・早・早・遅・遅・遅
          @point += 50
        elsif val.count(1) >= 2 && val.count(2) >= 2 && val.count(3) == 1
          # 早・早・遅・遅・フル
          @point += 50
        end

      else
        #　平日

        # 3or4名体制でない
        if val.count(0) > 2
          @point += -50
        end

        # 3人が同じ時間帯
        if val.count(1) == 3 || val.count(2) == 3 || val.count(3) == 3
          @point += -30
        end

        if val.count(1) == 2 && val.count(2) == 2 && val.count(0) == 2
          # 早・早・遅・遅
          @point += 50
        elsif val.count(1) == 1 && val.count(2) == 1 && val.count(3) == 1 && val.count(0) == 3
          # 早・遅・フル
          @point += 50
        end

      end
    end

  end

end