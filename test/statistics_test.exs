defmodule StatisticsTest do
  use ExUnit.Case
  doctest Statistics

  test "Best case entropy" do
    rows = [["Sunny", "Hot", "High", "Weak", "No"],
     ["Sunny", "Hot", "High", "Strong", "No"],
     ["Overcast", "Hot", "High", "Weak", "Yes"],
     ["Rain", "Mild", "High", "Weak", "Yes"]]

    result = Statistics.entropy(rows)
    assert result == 1
  end

  test "Worst case entropy" do
    rows = [["Sunny", "Hot", "High", "Weak", "No"],
     ["Sunny", "Hot", "High", "Strong", "No"],
     ["Overcast", "Hot", "High", "Weak", "No"],
     ["Rain", "Mild", "High", "Weak", "No"]]

    result = Statistics.entropy(rows)
    assert result == 0
  end

  test "Middle ground entropy" do
    rows = [["Sunny", "Hot", "High", "Weak", "No"],
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

    result = Statistics.entropy(rows)
    assert result == 0.9402859586706311
  end

  test "Information gain" do
    attributes = ["outlook", "temperature", "humidity", "wind", "play?"]
    rows = [["Sunny", "Hot", "High", "Weak", "No"],
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
    attribute= "humidity"

    result = Statistics.information_gain(rows, attributes, attribute)
    assert result == 0.15183550136234164
  end
end
