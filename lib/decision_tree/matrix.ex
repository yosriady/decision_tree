defmodule Matrix do
  @moduledoc """
    This module implements several helpful matrix (list of lists) traversals.
  """

  def get_classes(rows) do
    get_values(rows, -1)
  end

  def get_values(rows, attribute_index) do
    rows
    |> Enum.map(fn row -> Enum.fetch!(row, attribute_index) end)
  end

  def get_rows_with_value(rows, attribute_index, value) do
    rows
    |>Enum.filter(fn(row) -> Enum.fetch!(row, attribute_index) == value end)
  end
end
