require 'pry'

# From: https://en.wikipedia.org/wiki/Earth_radius
EARTH_MEAN_RADIUS_IN_METERS = 6357000.0.freeze

# From: https://en.wikipedia.org/wiki/Radian
RAD = 0.017453292519943295.freeze

# From: https://www.thoughtco.com/degree-of-latitude-and-longitude-distance-4070616
METERS_PER_LATITUDE_DEGREE = 111000.0.freeze

# From: http://www.csgnetwork.com/degreelenllavcalc.html
METERS_PER_LONGITUDE_DEGREE = 111302.62.freeze

def extract_coordinates(p1, p2, method)
		# Coordinates
	lat1, lon1 = p1
	lat2, lon2 = p2
	
	lat1 *= RAD if method == :spherical
	lon1 *= RAD if method == :spherical
	lat2 *= RAD if method == :spherical
	lon2 *= RAD if method == :spherical

	[lat1, lon1, lat2, lon2]
end

def spherical_distance_between(p1, p2)
	# Coordinates
	lat1, lon1, lat2, lon2 = extract_coordinates(p1, p2, :spherical)

	# Deltas in degrees if linear in radians if spherical
	dlat = lat2 - lat1
	dlon = lon2 - lon1

	# Haversine
  a = (Math.sin(dlat / 2))**2 + Math.cos(lat1) *
      (Math.sin(dlon / 2))**2 * Math.cos(lat2)
  c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
  distance = c * EARTH_MEAN_RADIUS_IN_METERS
end

# Only for small distances. For big distances, the error will be high.
def linear_distance_between(p1, p2)
	# # Coordinates
	lat1, lon1, lat2, lon2, dlat, dlon = extract_coordinates(p1, p2, :linear)
	
	# # Deltas in degrees if linear in radians if spherical
	dlat = lat2 - lat1
	dlon = lon2 - lon1

	# Linear calculation addition for longitude
	dlon *= Math.cos((lat1 + lat2)/2) * METERS_PER_LONGITUDE_DEGREE
	dlat *= METERS_PER_LATITUDE_DEGREE

	# Pythagoras
	distance = Math.sqrt(dlat**2 + dlon**2)
end

# p1 = [ARGV[0][0].to_f, ARGV[0][2].to_f] if ARGV
# p2 = [ARGV[1][0].to_f, ARGV[1][2].to_f] if ARGV
# linear_distance_between(p1, p2)
# spherical_distance_between(p1, p2)