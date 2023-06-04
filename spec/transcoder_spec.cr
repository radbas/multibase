require "./spec_helper"

describe Transcoder do
  describe "#encode" do
    it "encodes zero bytes correctly" do
      transcoder = Transcoder.new "123456789"
      payload = "00000000ffffffff".hexbytes
      encoded = transcoder.encode(payload)
      encoded.should eq "111123179768564"
    end
    it "encodes hello world with less than 62 emojis" do
      dict = "🧳🌂☂️🧵🪡🪢🧶👓🕶🥽🥼🦺👔👕👖🧣🧤🧥🧦👗👘🥻🩴🩱🩲" +
             "🩳👙👚👛👜👝🎒👞👟🥾🥿👠👡🩰👢👑👒🎩🎓🧢⛑🪖💄💍💼"
      payload = "Hello World"
      transcoder = Transcoder.new dict
      encoded = transcoder.encode(payload)
      encoded.should eq "☂🪢👟🩴🩰🥻👚👙🧢🩲🧥🥽🎩👙👝🎒"
    end
    it "encodes hello world with more than 62 emojis" do
      dict = "👋🚆🎠🥖🎏🍇🧳🌂☂️🧵🪡🪢🧶👓🕶🥽🥼🦺👔👕👖🧣🧤🧥🧦👗👘🥻🩴🩱🩲" +
             "🧀🧸🍔🏫🎳🍈🩳👙👚👛👜👝🎒👞👟🥾🥿👠👡🩰👢👑👒🎩🎓🧢⛑🪖💄💍💼"
      payload = "Hello World"
      transcoder = Transcoder.new dict
      encoded = transcoder.encode(payload)
      encoded.should eq "🍇👚🧤👝👜🕶👑🚆🍔🏫🪢🥽🎒🩴🎠"
    end
  end

  describe "#decode" do
    it "decodes zero bytes correctly" do
      transcoder = Transcoder.new "123456789"
      payload = "111123179768564"
      decoded = transcoder.decode(payload)
      decoded.should eq "00000000ffffffff".hexbytes
    end
    it "decodes hello world with less than 62 emojis" do
      dict = "🧳🌂☂️🧵🪡🪢🧶👓🕶🥽🥼🦺👔👕👖🧣🧤🧥🧦👗👘🥻🩴🩱🩲" +
             "🩳👙👚👛👜👝🎒👞👟🥾🥿👠👡🩰👢👑👒🎩🎓🧢⛑🪖💄💍💼"
      payload = "☂🪢👟🩴🩰🥻👚👙🧢🩲🧥🥽🎩👙👝🎒"
      transcoder = Transcoder.new dict
      decoded = transcoder.decode(payload)
      String.new(decoded).should eq "Hello World"
    end
    it "decodes hello world with more than 62 emojis" do
      dict = "👋🚆🎠🥖🎏🍇🧳🌂☂️🧵🪡🪢🧶👓🕶🥽🥼🦺👔👕👖🧣🧤🧥🧦👗👘🥻🩴🩱🩲" +
             "🧀🧸🍔🏫🎳🍈🩳👙👚👛👜👝🎒👞👟🥾🥿👠👡🩰👢👑👒🎩🎓🧢⛑🪖💄💍💼"
      payload = "🍇👚🧤👝👜🕶👑🚆🍔🏫🪢🥽🎒🩴🎠"
      transcoder = Transcoder.new dict
      decoded = transcoder.decode(payload)
      String.new(decoded).should eq "Hello World"
    end
  end
end
