defmodule MyString do
  def capitalize_sentences(str) do
    Enum.join(Enum.map(String.split(str, ". "), &String.capitalize/1), ". ")
  end
end