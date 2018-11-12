defmodule ZBase32 do
  @moduledoc ~S"""
  Z-Base-32: human-oriented base-32 encoding

  http://philzimmermann.com/docs/human-oriented-base-32-encoding.txt
  """
  use Bitwise

  @doc ~S"""
  Encodes a binary string into a z-base-32 encoded string.
  """
  @spec encode(binary) :: String.t
  def encode(<<>>), do: <<>>
  def encode(data) when is_binary(data) do
    split =  5 * div(byte_size(data), 5)
    <<main::size(split)-binary, rest::binary>> = data
    main = for <<c::5 <- main>>, into: <<>>, do: <<enc(c)::8>>
    case rest do
      <<c1::5, c2::5, c3::5, c4::5, c5::5, c6::5, c7::2>> ->
        <<main::binary,
          enc(c1)::8, enc(c2)::8,
          enc(c3)::8, enc(c4)::8,
          enc(c5)::8, enc(c6)::8,
          enc(bsl(c7, 3))::8>>
      <<c1::5, c2::5, c3::5, c4::5, c5::4>> ->
        <<main::binary,
          enc(c1)::8, enc(c2)::8,
          enc(c3)::8, enc(c4)::8,
          enc(bsl(c5, 1))::8>>
      <<c1::5, c2::5, c3::5, c4::1>> ->
        <<main::binary,
          enc(c1)::8, enc(c2)::8,
          enc(c3)::8, enc(bsl(c4, 4))::8>>
      <<c1::5, c2::3>> ->
        <<main::binary,
          enc(c1)::8, enc(bsl(c2, 2))::8>>
      <<>> ->
        main
    end
  end

  @doc ~S"""
  Decodes a z-base-32 encoded string into a binary string.
  """
  @spec decode(String.t) :: {:ok, binary} | :error
  def decode(string) when is_binary(string) do
    {:ok, decode!(string)}
  rescue
    ArgumentError -> :error
  end

  @doc ~S"""
  Decodes a z-base-32 encoded string into a binary string.

  An ArgumentError is raised if the input string is not a z-base-32 encoded string.
  """
  @spec decode!(String.t) :: binary
  def decode!(<<>>), do: <<>>
  def decode!(string) when is_binary(string) do
    do_decode(string)
  end

  defp do_decode(string) do
    split = byte_size(string) - rem(byte_size(string), 8)
    <<main::size(split)-binary, rest::binary>> = string
    main = for <<c::8 <- main>>, into: <<>>, do: <<dec(c)::5>>
    case rest do
      <<c1::8, c2::8>> ->
        <<main::binary, dec(c1)::5,
          bsr(dec(c2), 2)::3>>
      <<c1::8, c2::8, c3::8, c4::8>> ->
        <<main::binary,
          dec(c1)::5, dec(c2)::5,
          dec(c3)::5, bsr(dec(c4), 4)::1>>
      <<c1::8, c2::8, c3::8, c4::8, c5::8>> ->
        <<main::binary,
          dec(c1)::5, dec(c2)::5,
          dec(c3)::5, dec(c4)::5,
          bsr(dec(c5), 1)::4>>
      <<c1::8, c2::8, c3::8, c4::8, c5::8, c6::8, c7::8>> ->
        <<main::binary,
          dec(c1)::5, dec(c2)::5,
          dec(c3)::5, dec(c4)::5,
          dec(c5)::5, dec(c6)::5,
          bsr(dec(c7), 3)::2>>
      <<c1::8, c2::8, c3::8, c4::8, c5::8, c6::8, c7::8, c8::8>> ->
        <<main::binary,
          dec(c1)::5, dec(c2)::5,
          dec(c3)::5, dec(c4)::5,
          dec(c5)::5, dec(c6)::5,
          dec(c7)::5, dec(c8)::5>>
      <<>> ->
        main
      _ -> raise ArgumentError, "string must be a valid z-base-32 encoded string."
    end
  end

  alphabet = Enum.with_index 'ybndrfg8ejkmcpqxot1uwisza345h769'
  for {encoding, value} <- alphabet do
    defp enc(unquote(value)), do: unquote(encoding)
    defp dec(unquote(encoding)), do: unquote(value)
  end
  defp dec(c) do
    raise ArgumentError, "non-alphabet digit found: #{<<c>>}"
  end
end
