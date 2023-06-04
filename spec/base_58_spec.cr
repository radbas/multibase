require "./spec_helper"

describe Base58 do
  describe ".encode" do
    it "encodes hello world correctly" do
      payload = "Hello World"
      encoded = Base58.encode(payload)
      encoded.should eq "JxF12TrwUP45BMd"
    end
    it "encodes unicode correctly" do
      payload = "Hello, 世界"
      encoded = Base58.encode(payload)
      encoded.should eq "72k1xXWG5AsuJ7FFns"
    end
    it "encodes zero byte correctly" do
      payload = "00".hexbytes
      encoded = Base58.encode(payload)
      encoded.should eq "1"
    end
    it "encodes leading zero bytes correctly" do
      payload = "00000000ffffffff".hexbytes
      encoded = Base58.encode(payload)
      encoded.should eq "11117YXq9G"
    end
    it "encodes multiple bytes correctly" do
      payload = "ffffffff00000000".hexbytes
      encoded = Base58.encode(payload)
      encoded.should eq "jpXCZY5jqM9"
    end
  end

  describe ".decode" do
    it "decodes hello world correctly" do
      payload = "JxF12TrwUP45BMd"
      decoded = Base58.decode(payload)
      String.new(decoded).should eq "Hello World"
    end
    it "decodes unicode correctly" do
      payload = "72k1xXWG5AsuJ7FFns"
      decoded = Base58.decode(payload)
      String.new(decoded).should eq "Hello, 世界"
    end
    it "decodes zero byte correctly" do
      payload = "1"
      decoded = Base58.decode(payload)
      decoded.should eq "00".hexbytes
    end
    it "decodes leading zero bytes correctly" do
      payload = "11117YXq9G"
      decoded = Base58.decode(payload)
      decoded.should eq "00000000ffffffff".hexbytes
    end
    it "decodes multiple bytes correctly" do
      payload = "jpXCZY5jqM9"
      decoded = Base58.decode(payload)
      decoded.should eq "ffffffff00000000".hexbytes
    end
  end
end
