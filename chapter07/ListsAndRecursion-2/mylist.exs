defmodule MyList do
  def listmax([]), do: nil
  def listmax([head|tail]), do: _max(tail, head)

  def _max([], val), do: val
  def _max([head|tail], val) do
    _max(tail, max(head, val))
  end
end