defmodule MyString do
  def anagram?(word1, word2) do
    reverse(word1, []) == word2
  end

  defp reverse([], acc),do: acc
  defp reverse([h|t], acc), do: reverse(t, [h] ++ acc)
  
end