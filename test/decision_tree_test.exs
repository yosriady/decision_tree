defmodule DecisionTreeTest do
  use ExUnit.Case
  doctest DecisionTree

  test "Get most discriminatory attribute" do
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
    result = DecisionTree.get_most_discriminatory_attribute(rows, attributes)
    assert result == "outlook"
  end

  # test "Train classifier, tiny tree" do
  #   attributes = ["outlook", "play?"]
  #   rows = [["Sunny", "No"],
  #    ["Sunny", "No"],
  #    ["Overcast", "Yes"],
  #    ["Rain", "Yes"],
  #    ["Rain", "Yes"],
  #    ["Rain", "No"],
  #    ["Overcast", "Yes"],
  #    ["Sunny", "No"],
  #    ["Sunny", "Yes"],
  #    ["Rain", "Yes"],
  #    ["Sunny", "Yes"],
  #    ["Overcast", "Yes"],
  #    ["Overcast", "Yes"],
  #    ["Rain", "No"]]
  #   result = DecisionTree.train(attributes, rows)
  #   assert result == 1
  # end


    # test "Train classifier" do
    #   attributes = ["outlook", "temperature", "humidity", "wind", "play?"]
    #   rows = [["Sunny", "Hot", "High", "Weak", "No"],
    #    ["Sunny", "Hot", "High", "Strong", "No"],
    #    ["Overcast", "Hot", "High", "Weak", "Yes"],
    #    ["Rain", "Mild", "High", "Weak", "Yes"],
    #    ["Rain", "Cool", "Normal", "Weak", "Yes"],
    #    ["Rain", "Cool", "Normal", "Strong", "No"],
    #    ["Overcast", "Cool", "Normal", "Strong", "Yes"],
    #    ["Sunny", "Mild", "High", "Weak", "No"],
    #    ["Sunny", "Cool", "Normal", "Weak", "Yes"],
    #    ["Rain", "Mild", "Normal", "Weak", "Yes"],
    #    ["Sunny", "Mild", "Normal", "Strong", "Yes"],
    #    ["Overcast", "Mild", "High", "Strong", "Yes"],
    #    ["Overcast", "Hot", "Normal", "Weak", "Yes"],
    #    ["Rain", "Mild", "High", "Strong", "No"]]
    #   result = DecisionTree.train(attributes, rows)
    #   assert result == 1
    # end

    test "Train classifier" do
      attributes = ["income", "credit history", "debt", "decision"]
      rows = [
        ["poor", "bad", "low", "reject"],
        ["poor", "good", "low", "approve"],
        ["poor", "unknown", "high", "reject"],
        ["poor", "unknown", "low", "approve"],
        ["poor", "unknown", "low", "approve"],
        ["poor", "unknown", "low", "reject"],
        ["medium", "bad", "high", "reject"],
        ["medium", "good", "high", "approve"],
        ["medium", "unknown", "high", "approve"],
        ["medium", "unknown", "low", "approve"],
        ["high", "bad", "low", "reject"],
        ["high", "good", "low", "approve"]
      ]
      result = DecisionTree.train(attributes, rows)
      assert result == 1
    end
end
