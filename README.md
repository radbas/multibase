# Multibase.cr

Base transcoder for Base62, Base58, Base85 (RFC 1924), BaseN with multibyte character alphabet support.
This library performs byte by byte transcodings and is not compatible with RFC 4648.

> Do not use for Base16, Base32, Base64 or basE91

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     multibase:
       github: radbas/multibase
   ```

2. Run `shards install`

## Usage

```crystal
require "multibase"

base62 = Multibase::Base62.encode("Hello World")
p base62 # 73XpUgyMwkGr29M

decoded = Multibase::Base62.decode("73XpUgyMwkGr29M")
p String.new(decoded) # Hello World

# custom transcoder
transcoder = Multibase::Transcoder.new("123456789custom")

# transcoder.encode()
# transcoder.decode()
```

## Contributing

1. Fork it (<https://github.com/radbas/multibase/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Johannes Rabausch](https://github.com/jrabausch) - creator and maintainer
