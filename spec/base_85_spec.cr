require "./spec_helper"

describe Base85 do
  describe ".encode" do
    it "encodes hello world correctly" do
      payload = "Hello World"
      encoded = Base85.encode(payload)
      encoded.should eq "7KPt{PR^XAyM<W"
    end
    it "encodes unicode correctly" do
      payload = "Hello, 世界"
      encoded = Base85.encode(payload)
      encoded.should eq "%uJ|<6#K5c<7qI0h"
    end
    it "encodes zero byte correctly" do
      payload = "00".hexbytes
      encoded = Base85.encode(payload)
      encoded.should eq "0"
    end
    it "encodes leading zero bytes correctly" do
      payload = "00000000ffffffff".hexbytes
      encoded = Base85.encode(payload)
      encoded.should eq "0000|NsC0"
    end
    it "encodes multiple bytes correctly" do
      payload = "ffffffff00000000".hexbytes
      encoded = Base85.encode(payload)
      encoded.should eq "_sw2<`kSC0"
    end
  end

  describe ".decode" do
    it "decodes hello world correctly" do
      payload = "7KPt{PR^XAyM<W"
      decoded = Base85.decode(payload)
      String.new(decoded).should eq "Hello World"
    end
    it "decodes unicode correctly" do
      payload = "%uJ|<6#K5c<7qI0h"
      decoded = Base85.decode(payload)
      String.new(decoded).should eq "Hello, 世界"
    end
    it "decodes zero byte correctly" do
      payload = "0"
      decoded = Base85.decode(payload)
      decoded.should eq "00".hexbytes
    end
    it "decodes leading zero bytes correctly" do
      payload = "0000|NsC0"
      decoded = Base85.decode(payload)
      decoded.should eq "00000000ffffffff".hexbytes
    end
    it "decodes multiple bytes correctly" do
      payload = "_sw2<`kSC0"
      decoded = Base85.decode(payload)
      decoded.should eq "ffffffff00000000".hexbytes
    end
  end
end
