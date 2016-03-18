require "minitest/autorun"

require 'securerandom'
require "fcrc32"
require "zlib"

class TestFCrc32 < Minitest::Test

  DUMMY_FILE = "test/fixtures/dummy_5.txt"

  def setup
    @str = SecureRandom.random_bytes(10)
  end

  def test_zlib_fcrc32
    assert_equal Zlib.crc32(@str), FCrc32.calculate(@str)
  end

  def test_chunks
    @chunk    = @str[0, 3]
    @rest     = @str[3, @str.size]
    full_crc  = FCrc32.calculate(@str)
    chunk_crc = FCrc32.calculate(@chunk)

    assert_equal full_crc, FCrc32.c_calculate(@rest, @rest.bytesize, chunk_crc)
  end

  def test_random_str
    str = SecureRandom.random_bytes(2 ** 10)

    assert_equal Zlib.crc32(str), FCrc32.calculate(str)
  end

  def test_file_crc
    skip("dummy file not exist, please use `rake test:dummy`") unless File.exist?(DUMMY_FILE)
    zlib_crc32 = Zlib.crc32(File.read(DUMMY_FILE))

    assert_equal zlib_crc32, FCrc32.file(DUMMY_FILE)
    assert_equal zlib_crc32, FCrc32.chunked_file(DUMMY_FILE)
  end

end
