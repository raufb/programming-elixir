defmodule MyString do
  def center(strings) do
    max_length = Enum.max(Enum.map(strings, &String.length/1))
    _center(strings, max_length)
  end

  defp _center([str], max_length), do: _printatcenter(str, max_length)

  defp _center([h|t], max_length) do
    _printatcenter(h, max_length)
    _center(t, max_length)
  end

  defp _printatcenter(str, max_length) do
    str_length = String.length(str)
    trail_wspace = round((max_length + str_length)/2)
    IO.puts String.rjust(String.ljust(str, trail_wspace), max_length)
  end
end