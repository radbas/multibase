require "./base"

# Base85
#
# RFC 1924
# https://datatracker.ietf.org/doc/html/rfc1924
module Multibase::Base85
  extend Base
  extend self

  @@dict = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$%&()*+-;<=>?@^_`{|}~"

  private def the_base
    85
  end

  private def the_dict
    @@dict
  end
end
