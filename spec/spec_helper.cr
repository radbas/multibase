require "spec"
require "openssl/md5"
require "../src/multibase"

alias Transcoder = Multibase::Transcoder
alias Base58 = Multibase::Base58
alias Base62 = Multibase::Base62
alias Base85 = Multibase::Base85
