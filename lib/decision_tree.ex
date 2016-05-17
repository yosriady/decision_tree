defmodule DecisionTree do
  @moduledoc """
    This module implements the main training and classification procedures.
  """

  defstruct attributes: [], rows: [], options: [], tree: nil, rules: []

  @type attributes :: nonempty_list(String.t)
  @type datum :: nonempty_list(String.t)
  @type rows :: nonempty_list(datum)
  @type options :: list(tuple)
  @type classifier :: %DecisionTree{}
  @type class :: String.t

  @doc ~S"""
    Returns a trained decision tree classifier, given in some training data.

    ## Examples
      iex> data_attributes = ["weather", "temperature", "humidity", "wind", "play?"]
      ["weather", "temperature", "humidity", "wind", "play?"]
      iex> data_rows = [
      ...>    ["Sunny","Hot","High","Weak","No"],
      ...>    ["Sunny","Hot","High","Strong","No"],
      ...>    ["Overcast","Hot","High","Weak","Yes"],
      ...>    ["Rain","Mild","High","Weak","Yes"],
      ...>    ["Rain","Cool","Normal","Weak","Yes"],
      ...>    ["Rain","Cool","Normal","Strong","No"],
      ...>    ["Overcast","Cool","Normal","Strong","Yes"],
      ...>    ["Sunny","Mild","High","Weak","No"],
      ...>    ["Sunny","Cool","Normal","Weak","Yes"],
      ...>    ["Rain","Mild","Normal","Weak","Yes"],
      ...>    ["Sunny","Mild","Normal","Strong","Yes"],
      ...>    ["Overcast","Mild","High","Strong","Yes"],
      ...>    ["Overcast","Hot","Normal","Weak","Yes"],
      ...>    ["Rain","Mild","High","Strong","No"]
      ...>]
      [["Sunny", "Hot", "High", "Weak", "No"],
       ["Sunny", "Hot", "High", "Strong", "No"],
       ["Overcast", "Hot", "High", "Weak", "Yes"],
       ["Rain", "Mild", "High", "Weak", "Yes"],
       ["Rain", "Cool", "Normal", "Weak", "Yes"],
       ["Rain", "Cool", "Normal", "Strong", "No"],
       ["Overcast", "Cool", "Normal", "Strong", "Yes"],
       ["Sunny", "Mild", "High", "Weak", "No"],
       ["Sunny", "Cool", "Normal", "Weak", "Yes"],
       ["Rain", "Mild", "Normal", "Weak", "Yes"],
       ["Sunny", "Mild", "Normal", "Strong", "Yes"],
       ["Overcast", "Mild", "High", "Strong", "Yes"],
       ["Overcast", "Hot", "Normal", "Weak", "Yes"],
       ["Rain", "Mild", "High", "Strong", "No"]]
      iex> classifier = DecisionTree.train(data_attributes, data_rows)
      %DecisionTree{}
  """
  @spec train(attributes, rows, options) :: classifier
  def train(attributes, rows, options \\ []) do
    # TODO
    %DecisionTree{attributes: attributes, rows: rows, options: options}
  end

  defp build(rows, attributes, tree) do
    {has_homogenous_classification, classification} = has_homogenous_classification?(rows)
    cond do
      has_homogenous_classification ->
        %TreeNode{value: classification}
      Enum.empty?(attributes) ->
        get_most_common_classification(rows)
      _ ->
        # TODO: otherwise begin 

    end


  end

  # Checks if all given rows have the same classification.
  def has_homogenous_classification?(rows) do
    is_homogenous?(rows, -1)
  end

  # Checks if a column at all given rows have the same value
  defp is_homogenous?(rows, index) do
    values = rows
      |> Enum.flat_map(fn row -> Enum.take(row, index) end)
    is_homogenous = ((values
      |> Enum.dedup
      |> Enum.count) == 1)
    case is_homogenous do
      true -> {true, Enum.fetch!(values, 0)}
      false -> {false, nil}
    end
  end

  def get_most_common_classification(rows) do
    get_most_common(rows, -1)
  end

  # Returns the most common value for a given attribute index
  def get_most_common(rows, index) do
    occurences = rows
      |> Enum.flat_map(fn row -> Enum.take(row, index) end)
      |> Enum.group_by((&(&1)))
    most_common = occurences
      |> Map.keys
      |> Enum.reduce(%{}, fn key, acc ->
        Map.put(acc, key,
                (Map.get(occurences, key) |> Enum.count))
      end)
      |> Enum.reduce({:none, -1}, fn {key, value}, {max_key, max_value} ->
        if value > max_value, do: {key, value}, else: {max_key, max_value}
      end)
    {value, _} = most_common
    value
  end

  @doc ~S"""
    Returns a predicted class, given an unseen datum.
  """
  @spec classify(datum) :: class
  def classify(datum) do
    # TODO
    "placeholder"
  end

end
