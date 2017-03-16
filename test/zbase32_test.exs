defmodule ZBase32Test do
  use ExUnit.Case
  use EQC.ExUnit
  doctest ZBase32

  import ZBase32

  test "Base64 alphabet" do
    input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    assert (input |> encode() |> decode()) == {:ok, input}
  end

  test "gibberish" do
    assert decode("gibberish") == :error
  end

  test "empty string" do
    assert ("" |> encode() |> decode()) == {:ok, ""}
  end

  property "encoding" do
    forall input <- largebinary({:limit, 0, 512}) do
      ensure (input |> encode() |> decode()) == {:ok, input}
    end
  end
end
