defmodule Utility2 do

  # result number1 + number2
  def addNumber(number1,number2) do
    number1 + number2
  end

  def clean_up_data(data) do
    data_0 = Enum.map(data, fn x -> Map.delete(x, :__meta__) end)
    data_1 = Enum.map(data_0, fn x -> Map.delete(x, :inserted_at) end)
    data_2 = Enum.map(data_1, fn x -> Map.delete(x, :updated_at) end)
    cleaned_data = Enum.map(data_2, fn x -> Map.delete(x, :__struct__) end)
    cleaned_data
  end

end
