defmodule FizzBuzz do

  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  def fizzbuzz(n) do
    case min(1,rem(n,3)) + min(1,rem(n,5)) * 2  do
    0 -> "FizzBuzz"
    1 -> "Buzz"
    2 -> "Fizz"
    3 -> n
    end
  end

end