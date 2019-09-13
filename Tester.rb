require "test/unit"

# == Class Tester
#
# Author :: Joaquin Abeiro
#
# This class test the server
#
# === Composition
#
# Definition of the _Tester_ class composed of :
# * method test_parse
# * method test_failure

class Tester < Test::Unit::TestCase implements ITester

  def test_parse(request)
    assert_equal(3, (parse(request).length))
    assert_equal(3, (parse_headers(request).length))
  end

  def test_failure
    assert_equal(4, (parse(request).length), "Something doesn't work" )
  end

end