defmodule TreeNode do
  defstruct value: "", children: []

  @type value :: String.t
  @type child :: %TreeNode{}
  @type children :: [] | list(child)
  @type tree_node :: %TreeNode{}

  @spec new(value, children) :: tree_node
  def new(value, children \\ []) do
    %TreeNode{value: value, children: children}
  end
end
