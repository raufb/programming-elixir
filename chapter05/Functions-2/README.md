# Exercise: Functions-2

## Solution

```Elixir
fizzbuzz = fn  
  0, 0, _ -> FizzBuzz  
  0, _, _ -> Fizz  
  _, 0, _ -> Buzz  
  _, _, a -> a  
end
```
