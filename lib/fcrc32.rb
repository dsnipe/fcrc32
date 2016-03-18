require_relative 'fcrc32/fcrc32'

module FCrc32
  CHUNK_SIZE = 1024

  def self.calculate(str)
    c_calculate(str, str.bytesize, 0)
  end

  def self.file(filepath)
    calculate(File.read(filepath))
  end

  def self.chunked_file(filepath, chunk_size = 1024)
    File.open(filepath, "rb") do |f|
      while buffer = f.read(chunk_size) do
        temp_crc = c_calculate(buffer, chunk_size, temp_crc || 0)
      end
      temp_crc
    end
  end

end

