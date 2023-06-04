require "./spec_helper"

describe Base62 do
  describe ".encode" do
    it "encodes hello world correctly" do
      payload = "Hello World"
      encoded = Base62.encode(payload)
      encoded.should eq "73XpUgyMwkGr29M"
    end
    it "encodes unicode correctly" do
      payload = "Hello, 世界"
      encoded = Base62.encode(payload)
      encoded.should eq "1wJfrzvdbuFbL65vcS"
    end
    it "encodes zero byte correctly" do
      payload = "00".hexbytes
      encoded = Base62.encode(payload)
      encoded.should eq "0"
    end
    it "encodes leading zero bytes correctly" do
      payload = "00000000ffffffff".hexbytes
      encoded = Base62.encode(payload)
      encoded.should eq "00004gfFC3"
    end
    it "encodes multiple bytes correctly" do
      payload = "ffffffff00000000".hexbytes
      encoded = Base62.encode(payload)
      encoded.should eq "LygHZwPV2MC"
    end
    it "encodes md5 correctly" do
      payload = OpenSSL::MD5.hash("Hello World").to_slice
      encoded = Base62.encode(payload)
      encoded.should eq "5O4SoozqXEOwlYtvkC5zkr"
    end
    it "encodes numbers correctly" do
      payload = 91574294826053
      encoded = Base62.encode(payload)
      encoded.should eq "Q0DRQksv"
    end
  end

  describe ".decode" do
    it "decodes hello world correctly" do
      payload = "73XpUgyMwkGr29M"
      decoded = Base62.decode(payload)
      String.new(decoded).should eq "Hello World"
    end
    it "decodes unicode correctly" do
      payload = "1wJfrzvdbuFbL65vcS"
      decoded = Base62.decode(payload)
      String.new(decoded).should eq "Hello, 世界"
    end
    it "decodes zero byte correctly" do
      payload = "0"
      decoded = Base62.decode(payload)
      decoded.should eq "00".hexbytes
    end
    it "decodes leading zero bytes correctly" do
      payload = "00004gfFC3"
      decoded = Base62.decode(payload)
      decoded.should eq "00000000ffffffff".hexbytes
    end
    it "decodes multiple bytes correctly" do
      payload = "LygHZwPV2MC"
      decoded = Base62.decode(payload)
      decoded.should eq "ffffffff00000000".hexbytes
    end
  end
end
