require_relative "distance_between"
require "test/unit"

class TestDistanceBetween < Test::Unit::TestCase
 
  def test_spherical_distance_between
    assert_equal 110951, spherical_distance_between([0,0], [0,1]).round
  end

  def test_linear_distance_between
    assert_equal 111303, linear_distance_between([0,0], [0,1]).round
  end

	def test_linear_distance_between_two_close_points
    assert_equal 176, linear_distance_between([52.531151,13.375673], [52.531941,13.377818]).round
  end

  def test_spherical_distance_between_two_close_points
    assert_equal 169, spherical_distance_between([52.531151,13.375673], [52.531941,13.377818]).round
  end

  def test_spherical_distance_between_la_city_hall_to_ny_city_hall
  	distance = spherical_distance_between([34.0459068,-118.2715222], [40.7127784,-74.0082477]).round
  	google_distance = 4489000.0

  	# less than 300m of error for long distances
  	assert(((distance - google_distance).abs / 1000) < 600) 
  end

  def test_linear_distance_between_la_city_hall_to_ny_city_hall
  	distance = linear_distance_between([34.0459068,-118.2715222], [40.7127784,-74.0082477]).round
  	google_distance = 4489000.0

  	# less than 600m for long distances
  	assert(((distance - google_distance).abs / 1000) < 600) 
  end
  
end