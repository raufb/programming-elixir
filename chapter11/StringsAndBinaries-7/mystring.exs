defmodule MyString do

  def calculate_total(file) do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    parse(file) |> _calculate_total(tax_rates)
  end

  def _calculate_total(orders, tax_rates) do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    for order <- orders,
    	state = order[:ship_to],
    	tax_rate = if(is_nil(tax_rates[state]), do: 0, else: tax_rates[state]),
	total = order[:net_amount] * (1 + tax_rate),
        do: order ++ [total_amount: total]
  end
  
  def parse(file) do
    [h|t] = File.open!(file) |> IO.stream(:line) |> Enum.to_list
    _parse(t, [])        
  end

  def _parse([], acc), do: acc

  def _parse([h|t], acc) do
    [idval, shipto, netamount] = h |> String.replace_suffix("\n", "") |> String.split(",")
    list =  [id: String.to_integer(idval), ship_to: String.to_atom(String.replace_prefix(shipto,":","")), net_amount: String.to_float(netamount)]
    _parse(t, acc ++ [list])
  end

end