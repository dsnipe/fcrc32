require "minitest/autorun"
require "minitest/benchmark"

require 'crc32'
require "zlib"
require 'fcrc32'

class Fcrc32Benchmark < Minitest::Benchmark

  def dummy_file(n = 5)
    "./test/fixtures/dummy_#{n}.txt"
  end

  def self.bench_range
    [1, 5, 50]
  end

  def bench_zlib
    assert_performance_linear do |n|
      Zlib.crc32(File.read(dummy_file(n)))
    end
  end

  def bench_fcrc32
    assert_performance_linear do |n|
      FCrc32.calculate(File.read(dummy_file(n)))
    end
  end

  def bench_crc32_lib
    assert_performance_linear do |n|
      file = File.read(dummy_file(n))
      Crc32.calculate(file, file.bytesize, 0)
    end
  end

end
