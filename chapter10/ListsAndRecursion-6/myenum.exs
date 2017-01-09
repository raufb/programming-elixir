defmodule MyEnum do
  def flatten(collection) do
    _flatten([], collection)
  end

  defp _flatten(result, []), do: result

  defp _flatten(result, [head|tail]) when is_list(head) do
    result ++ _flatten([], head ++ tail)
  end

  defp _flatten(result, [head|tail]) do
    _flatten(result ++ [head], tail)
  end
end