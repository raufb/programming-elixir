defmodule OK do

  def ok!({:ok, data}), do: data
  def ok!({_, data}), do: raise to_string(data)

end