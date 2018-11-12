defmodule ZBase32Test do
  use ExUnit.Case
  use EQC.ExUnit
  doctest ZBase32

  import ZBase32

  test "Base64 alphabet" do
    input = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    assert (input |> encode() |> decode()) == {:ok, input}
    assert (input |> encode() |> decode!()) == input
  end

  test "gibberish" do
    assert decode("gibberish") == :error
    assert_raise ArgumentError, fn ->
      decode!("gibberish")
    end
  end

  test "empty string" do
    assert ("" |> encode() |> decode()) == {:ok, ""}
    assert ("" |> encode() |> decode!()) == ""
  end

  property "encoding" do
    forall input <- largebinary({:limit, 0, 512}) do
      ensure (input |> encode() |> decode()) == {:ok, input}
      ensure (input |> encode() |> decode!()) == input
    end
  end
end
