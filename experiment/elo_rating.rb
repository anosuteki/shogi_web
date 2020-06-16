#!/usr/bin/env ruby
# app/models/actb/elo_rating.rb
# spec/models/actb/elo_rating_spec.rb
require File.expand_path('../../config/environment', __FILE__)

def test(n, a, b)
  d = Actb::EloRating.public_send("rating_update#{n}", a, b)
  d.round(2)
rescue => error
  error.message
end

test(1, 1500, 1899) # => 29.08
test(1, 1500, 1900) # => 29.09
test(1, 1500, 1901) # => 29.11
test(1, 1500, 9999) # => 32.0
test(1, 1899, 1500) # => 2.92
test(1, 1900, 1500) # => 2.91
test(1, 1901, 1500) # => 2.89
test(1, 9999, 1500) # => 0.0

test(2, 1500, 1899) # => 29.08
test(2, 1500, 1900) # => 29.09
test(2, 1500, 1901) # => 29.11
test(2, 1500, 9999) # => 32.0
test(2, 1899, 1500) # => 2.92
test(2, 1900, 1500) # => 2.91
test(2, 1901, 1500) # => 2.89
test(2, 9999, 1500) # => 1

test(3, 1500, 1899) # => 31.96
test(3, 1500, 1900) # => 32.0
test(3, 1500, 1901) # => "R差401 > 400 のとき加算値32.04が32を超える"
test(3, 1500, 9999) # => "R差8499 > 400 のとき加算値355.96が32を超える"
test(3, 1899, 1500) # => 0.04
test(3, 1900, 1500) # => "R差-400 == -400 のとき加算値0.0が0になる"
test(3, 1901, 1500) # => "R差-401 < -400 のとき加算値-0.03999999999999915がマイナスになる"
test(3, 9999, 1500) # => "R差-8499 < -400 のとき加算値-323.96がマイナスになる"

test(4, 1500, 1899) # => 31.96
test(4, 1500, 1900) # => 32.0
test(4, 1500, 1901) # => 32
test(4, 1500, 9999) # => 32
test(4, 1899, 1500) # => 1
test(4, 1900, 1500) # => 1
test(4, 1901, 1500) # => 1
test(4, 9999, 1500) # => 1
