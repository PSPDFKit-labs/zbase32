# ZBase32

[![Build Status](http://quickcheck-ci.com/p/pspdfkit-labs/zbase32.svg)](http://quickcheck-ci.com/p/pspdfkit-labs/zbase32)
[![Module Version](https://img.shields.io/hexpm/v/zbase32.svg)](https://hex.pm/packages/zbase32)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/zbase32/)
[![Total Download](https://img.shields.io/hexpm/dt/zbase32.svg)](https://hex.pm/packages/zbase32)
[![License](https://img.shields.io/hexpm/l/zbase32.svg)](https://github.com/pspdfkit-labs/zbase32/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/pspdfkit-labs/zbase32.svg)](https://github.com/pspdfkit-labs/zbase32/commits/master)


Efficient implementation of [z-base-32](https://en.wikipedia.org/wiki/Base32#z-base-32), Phil
Zimmermann's [human-oriented base-32 encoding](http://philzimmermann.com/docs/human-oriented-base-32-encoding.txt).

> z-base-32 is a Base32 encoding designed to be easier for human use and more compact. It includes
> 1, 8 and 9 but excludes l, v and 2. It also permutes the alphabet so that the easier characters
> are the ones that occur more frequently. It compactly encodes bitstrings whose length in bits is
> not a multiple of 8, and omits trailing padding characters. z-base-32 was used in Mnet open source
> project, and is currently used in Phil Zimmermann's ZRTP protocol, and in the Tahoe-LAFS open
> source project.

## Installation and usage

1. Add `:zbase32` to your list of dependencies in `mix.exs`:

   ```elixir
   def deps do
     [
       {:zbase32, "~> 1.0.0"}
     ]
   end
   ```

2. Start encoding and decoding:

   ```elixir
   ZBase32.encode("hello") # => "pb1sa5dx"
   ZBase32.decode("pb1sa5dx") # => "hello"
   ```

## Test coverage

We're using [QuiviQ's QuickCheck](http://www.quviq.com/products/erlang-quickcheck/) to ensure correct roundtrips.:

```elixir
forall input <- largebinary({:limit, 0, 512}) do
  ensure (input |> ZBase32.encode() |> ZBase32.decode()) == input
end
```

Check out the project on http://quickcheck-ci.com.

This implementation has also manually been verified against the Python
[zbase32 1.1.5](https://pypi.python.org/pypi/zbase32/) package.


## Copyright and License

Copyright (c) 2015 PSPDFKit GmbH (pspdfkit.com)

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
