require 'test/unit'
require "TimeModel.rb"

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