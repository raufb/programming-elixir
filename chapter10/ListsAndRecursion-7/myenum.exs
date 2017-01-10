defmodule MyEnum do

  defp _span(from, from), do: [from]
  defp _span(from, to) when from < to, do: [from | _span(from+1, to)]
  defp _span(from, to) when from > to, do: [from | _span(from-1, to)]

  def prim(n) do
    for input <- _span(2,n),
    	!Enum.any?(_span(2,round(Float.ceil(:math.sqrt(input)))),&(rem(input,&1) == 0)),
    	into: [2]
    	do input
    end
  end

end