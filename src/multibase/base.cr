require "big/lib_gmp"

module Multibase::Base
  alias BigEndian = IO::ByteFormat::BigEndian

  GMP = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  def the_dict : String
    GMP
  end

  private def the_map : String
    ""
  end

  private def the_base : Int32
    62
  end

  def encode(data : String | Bytes) : String
    data = data.to_slice
    return "" if data.empty?

    String.build do |io|
      # leading zeros
      iz = 0
      while data[iz + 1]? && data[iz] == 0
        io << the_dict[0]
        iz += 1
      end

      # can use gmp?
      if the_base <= 62
        gmp_result = gmp_encode(data, the_base)

        if the_map.empty?
          io.write gmp_result
          next
        end

        gmp_result.each do |b|
          next if b == 0 # c null char
          index = the_map.index!(b.chr)
          io << the_dict[index]
        end
        next
      end

      res = String.build do |sio|
        convert(data.to_a, 256, the_base) do |c|
          sio << the_dict[c]
        end
      end

      io << res.reverse
    end
  end

  def encode(int : Int64) : String
    bytes = Bytes.new(sizeof(Int64))
    BigEndian.encode(int, bytes)
    while bytes[0] == 0
      bytes = bytes[1..-1]
    end
    encode(bytes)
  end

  def decode(str : String) : Bytes
    io = IO::Memory.new
    return io.to_slice if str.empty?

    indexes = str.chars.map do |c|
      index = the_dict.index!(c)
      raise "invalid character detected" if index.nil?
      index.to_u8
    end

    # leading zeros
    iz = 0
    while indexes[iz + 1]? && indexes[iz] == 0
      io.write_byte 0x00
      iz += 1
    end

    if the_base <= 62
      # translate
      unless the_map.empty?
        str = String.build do |s|
          indexes.each do |i|
            s << the_map[i]
          end
        end
      end

      gmp_result = gmp_decode(str, the_base)
      hex = String.new(gmp_result)
      hex = "0#{hex}" unless hex.size % 2 == 0

      io.write hex.hexbytes
    else
      bio = IO::Memory.new
      convert(indexes, the_base, 256) do |c|
        bio.write_byte c
      end
      io.write bio.to_slice.reverse!
    end

    io.to_slice
  end

  private def convert(bytes : Array(UInt8), from_base : Int32, to_base : Int32, &)
    count = bytes.size
    while count > 0
      i = remainder = length = 0
      while i < count
        remainder = remainder * from_base + bytes[i]
        if remainder >= to_base
          bytes[length] = (remainder // to_base).to_u8
          remainder = remainder % to_base
          length += 1
        elsif length > 0
          bytes[length] = 0
          length += 1
        end
        i += 1
      end
      count = length
      yield remainder.to_u8
    end
  end

  private def gmp_encode(data : Bytes, base : Int32) : Bytes
    LibGMP.init_set_str(out mpz, data.hexstring, 16)
    ptr = LibGMP.get_str(nil, base, pointerof(mpz))
    size = LibGMP.sizeinbase(pointerof(mpz), base).to_i
    ptr.to_slice(size)
  end

  private def gmp_decode(str : String, base : Int32) : Bytes
    LibGMP.init_set_str(out mpz, str, base)
    ptr = LibGMP.get_str(nil, 16, pointerof(mpz))
    size = LibGMP.sizeinbase(pointerof(mpz), 16).to_i
    ptr.to_slice(size)
  end
end
