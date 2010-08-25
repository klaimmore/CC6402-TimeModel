require 'test/unit'

class TimeModel
    
    SECONDS_OF_MINUTE = 60
    MINUTES_OF_HOUR = 60
    HOURS_OF_DAY = 24

    attr_reader :hours
    attr_reader :minutes
    attr_reader :seconds
    
    def initialize(hour = 0, minute = 0, second = 0)
        @hours = hour
        @minutes = minute
        @seconds = second
    end
    
    def second_passed
=begin  #Refactoring this block
        
        if (@seconds +=1 ) >= 60
            @seconds = 0
            if (@minutes += 1) >= 60
                @minutes = 0
                if(@hours += 1) >= 24
                    @hours = 0
                end
            end
        end
=end
        @seconds = (@seconds+1)%SECONDS_OF_MINUTE
        if @seconds == 0
            minute_passed
        end
    end
    
    def minute_passed
        @minutes = (@minutes+1)%MINUTES_OF_HOUR
        if @minutes == 0
            hour_passed
        end
    end
    
    def hour_passed
        @hours = (@hours+1)%HOURS_OF_DAY
    end
    
    def to_s
        "%02d:%02d:%02d" % [@hours, @minutes, @seconds]
    end
end

class TimeModelTest < Test::Unit::TestCase
    def test_initialize
        t = TimeModel.new(1,2,3)
        assert_equal(1, t.hours)
        assert_equal(2, t.minutes)
        assert_equal(3, t.seconds)
        t = TimeModel.new()
        assert_equal(0, t.hours)
        assert_equal(0, t.minutes)
        assert_equal(0, t.seconds)
    end
    def test_second_passed
        t = TimeModel.new(0,0,0)
        t.second_passed
        assert_equal(0, t.hours)
        assert_equal(0, t.minutes)
        assert_equal(1, t.seconds)
    end
    def test_minute_passed
        t = TimeModel.new(0,0,59)
        t.second_passed()
        assert_equal(0, t.hours)
        assert_equal(1, t.minutes)
        assert_equal(0, t.seconds)
    end
    def test_hour_passed
        t = TimeModel.new(0,59,59)
        t.second_passed()
        assert_equal(1, t.hours)
        assert_equal(0, t.minutes)
        assert_equal(0, t.seconds)
    end
    def test_day_passed
        t = TimeModel.new(23,59,59)
        t.second_passed()
        assert_equal(0, t.hours)
        assert_equal(0, t.minutes)
        assert_equal(0, t.seconds)
    end
    def test_to_s
        t = TimeModel.new
        assert_equal("00:00:00", t.to_s)
        t = TimeModel.new(23,59,59)
        assert_equal("23:59:59", t.to_s)
    end
end