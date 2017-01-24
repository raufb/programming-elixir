defmodule MyString do
  def printable?([head|tail])
  when head in (?\s)..(?~) do
    printable?(tail)    
  end

  def printable?([]), do: True

  def printable?(_), do: False
end