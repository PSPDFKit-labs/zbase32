defmodule ZBase32Test do
  use ExUnit.Case
  use EQC.ExUnit
  doctest ZBase32

  import ZBase32

  test "Base64 alphabet" do
    input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    assert (input |> encode() |> decode()) == input
  end

  property "encoding" do
    forall input <- largebinary({:limit, 0, 512}) do
      ensure (input |> encode() |> decode()) == input
    end
  end
end
