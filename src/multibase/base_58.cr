require "./base"

module Multibase::Base58
  extend Base
  extend self

  @@dict = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
  @@map = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuv"

  private def the_base
    58
  end

  private def the_dict
    @@dict
  end

  private def the_map
    @@map
  end
end
