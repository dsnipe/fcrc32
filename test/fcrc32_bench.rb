require 'rubygems'
require 'bundler/setup'

require 'crc32'
require "zlib"
require 'fcrc32'

require 'benchmark'

class FCrc32Bench
  DUMMY_FILE =  "./test/fixtures/dummy_5.txt"

  def self.start(attempts = 10)
    instance = new
    Benchmark.bmbm(7) do |x|
      x.report("zlib") { attempts.times { instance.zlib_crc32 } }
      x.report("crc32_lib") { attempts.times { instance.crc32_lib } }
      x.report("current crc32") { attempts.times { instance.fcrc32 } }
    end
  end

  def zlib_crc32
    Zlib.crc32(File.read(DUMMY_FILE))
  end

  def fcrc32
    FCrc32.file DUMMY_FILE
  end

  def crc32_lib
    file = File.read(DUMMY_FILE)
    Crc32.calculate(file, file.bytesize, 0)
  end

end
