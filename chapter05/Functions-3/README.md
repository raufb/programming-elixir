# Exercise: Functions-3

## Solution

```Elixir
fizzbuzz = fn  
  0, 0, _ -> FizzBuzz  
  0, _, _ -> Fizz  
  _, 0, _ -> Buzz  
  _, _, a -> a  
end  
```

```Elixir
test_fizzbuzz = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end
```