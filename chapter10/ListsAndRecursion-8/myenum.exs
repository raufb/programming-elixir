defmodule MyEnum do
  def calculate_total(orders, tax_rates) do
    for order <- orders,
    	state = order[:ship_to],
    	tax_rate = if(is_nil(tax_rates[state]), do: 0, else: tax_rates[state]),
	total = order[:net_amount] * (1 + tax_rate),
        do: order ++ [total_amount: total]
  end

  def test_calculate_total do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    orders = [
      [ id: 123, ship_to: :NC, net_amount: 100.00 ],
      [ id: 124, ship_to: :OK, net_amount: 35.50 ],
      [ id: 125, ship_to: :TX, net_amount: 24.00 ],
      [ id: 126, ship_to: :TX, net_amount: 44.80 ],
      [ id: 127, ship_to: :NC, net_amount: 25.00 ],
      [ id: 128, ship_to: :MA, net_amount: 10.00 ],
      [ id: 129, ship_to: :CA, net_amount: 102.00 ],
      [ id: 130, ship_to: :NC, net_amount: 50.00 ] ]

    calculate_total(orders, tax_rates)
  end
end