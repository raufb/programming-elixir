defmodule MyEnum do
  def all?(collection, func), do: _all?([], collection, func)
  defp _all?(result, [], _func), do: result

  defp _all?(result, [head|tail], func) do
    if func.(head) == true do
      _all?(result ++ [head], tail, func)
    else
      _all?(result, tail, func)
    end
  end

  def each([], _func), do: :ok

  def each([head|tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter(collection, func), do: _filter([], collection, func)
  
  defp _filter(result, [], _func), do: result

  defp _filter(result, [head|tail], func) do
    if func.(head) do
      _filter(result ++ [head], tail, func)
    else
      _filter(result, tail, func)
    end
  end

  def split(collection, num) do
    _split([], collection, num)
  end

  defp _split(firstpart, [], _num), do: {firstpart, []}
  defp _split(firstpart, secondpart, 0), do: {firstpart, secondpart}
  
  defp _split(firstpart, [head|secondpart], num) do
    _split(firstpart ++ [head], secondpart, num-1)  
  end

  def take(collection, num), do: _take([], collection, num)

  defp _take(result, [], _num), do: result
  defp _take(result, _collection, 0), do: result
  
  defp _take(result, [head|tail], num) do
    _take(result ++ [head], tail, num-1)
  end
end