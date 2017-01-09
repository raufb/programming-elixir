defmodule MyList do
  def caesar([], _kod), do: []
  def caesar([head|tail], kod) do
    ciphernum = 96 * div(head+kod, 122) + rem(head+kod, 122)
    [ciphernum] ++ caesar(tail, kod)
  end
end