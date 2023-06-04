require "./base"

class Multibase::Transcoder
  include Base

  @base : Int32
  @dict : String
  @map : String = ""

  private def the_base
    @base
  end

  private def the_dict
    @dict
  end

  private def the_map
    @map
  end

  def initialize(alphabet : String)
    @base = alphabet.size
    raise "alphabet size must be greater than 2" if @base < 2
    @dict = alphabet
    raise "alphabet contains dublicate chars" unless @dict.chars.uniq!.size == @base

    # setup char map for gmp mapping
    if @base <= 62
      map = GMP[0..@base]
      map = map.downcase if @base <= 36
      @map = map unless map == @dict
    end
  end
end
