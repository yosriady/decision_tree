defmodule Statistics do
  require Math

  # Expected reduction in entropy caused by partition of rows according to
  # an attribute A
  def information_gain(rows, attributes, attribute) do
    attribute_index = Enum.find_index(attributes, &(&1 == attribute))
    values = rows |> Matrix.get_values(attribute_index)
    unique_values = values |> Enum.uniq

    Enum.reduce(unique_values, entropy(rows), fn(value, acc) ->
      rows_with_value = Matrix.get_rows_with_value(rows, attribute_index, value)
      acc - (Enum.count(rows_with_value) / Enum.count(rows)) * entropy(rows_with_value)
    end)
  end

  # A statistical measure used to characterize the purity of an arbitrary
  # collection of examples
  def entropy(rows) do
    classes = rows |> Matrix.get_classes
    unique_classes = classes |> Enum.uniq
    Enum.reduce(unique_classes, 0, fn(class, acc) ->
      acc - proportion_of_class(classes, class) * Math.log2(proportion_of_class(classes, class))
    end)
  end

  defp proportion_of_class(classes, class) do
    count_of_class(classes, class) / Enum.count(classes)
  end

  defp count_of_class(classes, class) do
    classes
    |> Enum.filter(fn(x) -> x == class end)
    |> Enum.count
  end
end
