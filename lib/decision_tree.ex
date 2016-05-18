defmodule DecisionTree do
  @moduledoc """
    This module implements the main training and classification functions.
  """

  defstruct attributes: [], rows: [], options: [], tree: %{}, rules: []

  @class_index -1 # The last/rightmost column is the class by default

  @type attributes :: nonempty_list(String.t)
  @type datum :: nonempty_list(String.t)
  @type rows :: nonempty_list(datum)
  @type options :: list(tuple)
  @type classifier :: %DecisionTree{}
  @type class :: String.t

  @doc ~S"""
    Returns a trained decision tree classifier, given in some training data.
  """
  @spec train(attributes, rows, options) :: classifier
  def train(attributes, rows, options \\ []) do
    tree = build(rows, attributes)
    %DecisionTree{attributes: attributes, rows: rows, tree: tree, options: options}
  end

  defp build(rows, attributes) do
    {has_homogenous_classification, classification} = has_homogenous_classification?(rows)
    attributes_except_class = List.delete_at(attributes, @class_index)
    cond do
      has_homogenous_classification ->
        classification
      Enum.empty?(attributes_except_class) ->
        get_most_common_classification(rows)
      true ->
        split_attribute = get_most_discriminatory_attribute(rows, attributes)
        split_attribute_index = Enum.find_index(attributes, &(&1 == split_attribute))
        split_attribute_values = Matrix.get_values(rows, split_attribute_index)

        # add a new tree branch for that value i.e. Strong
        # if attribute_value_rows is empty
          # return a leaf node with value the most common class in rows
        # else
          # build(value_i_rows, attributes - split_attribute)
        # for each possible value v-i i.e. Strong of split_attribute i.e. Wind

        branches = Enum.map(split_attribute_values, fn(attribute_value) ->
          # let attribute_value_rows be a subset of rows that have value attribute_value
          attribute_value_rows = Matrix.get_rows_with_value(rows, split_attribute_index, attribute_value)
          cond do
            Enum.empty?(attribute_value_rows) -> # if attribute_value_rows is empty
              class = get_most_common_classification(rows)
              Map.put(%{}, attribute_value, class) # return a leaf node with value the most common class in rows
            true -> # Recursive case
              subtree = build(attribute_value_rows, List.delete(attributes, split_attribute))
              Map.put(%{}, attribute_value, subtree)
          end
        end)

        merged_branches = (branches |> Enum.uniq |> Enum.reduce(%{}, fn(x, acc) -> Map.merge(x, acc) end))
        {split_attribute, merged_branches}
    end
  end

  # Tree should look like:
  # {"Wind", %{
  #     "Strong": {
  #         "Temperature", %{
  #             "High": "Play"
  #             "Low" : %{ // continued }
  #         }
  #       },
  #     "Weak": "Play"
  #     }
  #   }
  # }
  # Tuples for attributes, maps for values

  @doc ~S"""
    Returns a predicted class, given an unseen datum.
  """
  @spec classify(datum) :: class
  def classify(datum) do
    # TODO
    "placeholder"
  end


  # Picks an attribute from attributes that best classifies rows
  def get_most_discriminatory_attribute(rows, attributes) do
    attributes_except_class = List.delete_at(attributes, @class_index)
    gains = Enum.reduce(attributes_except_class, %{}, fn(attribute, acc) ->
      gain = Statistics.information_gain(rows, attributes, attribute)
      Map.put(acc, attribute, gain)
    end)
    case max_of_map(gains) do
      {attribute, _} when attribute != :error -> attribute
      _ -> raise "Failure at finding max_of_map for information gain"
    end
  end

  # Checks if all given rows have the same classification.
  def has_homogenous_classification?(rows) do
    is_homogenous?(rows, @class_index)
  end

  # Checks if a column at all given rows have the same value
  defp is_homogenous?(rows, index) do
    values = rows
      |> Enum.map(fn row -> Enum.fetch!(row, index) end)
    is_homogenous = ((values
      |> Enum.uniq
      |> Enum.count) == 1)
    case is_homogenous do
      true -> {true, Enum.fetch!(values, 0)}
      false -> {false, nil}
    end
  end

  # Returns the most common class for the given rows
  def get_most_common_classification(rows) do
    get_most_common(rows, @class_index)
  end

  # Returns a column's most common value for the given rows
  def get_most_common(rows, index) do
    occurences = rows
      |> Enum.map(fn row -> Enum.fetch!(row, index) end)
      |> Enum.group_by((&(&1)))
    most_common = occurences
      |> Map.keys
      |> Enum.reduce(%{}, fn key, acc ->
        Map.put(acc, key,
                (Map.get(occurences, key) |> Enum.count))
      end)
      |> max_of_map
    {value, _} = most_common
    value
  end

  # Returns the {key, value} with the largest value in a map, else {:none, -1}
  def max_of_map(map) do
    Enum.reduce(map, {:none, -1}, fn {key, value}, {max_key, max_value} ->
      if value > max_value, do: {key, value}, else: {max_key, max_value}
    end)
  end
end
