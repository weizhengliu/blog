defmodule BlogWeb.CalculatorComponent do
  use Phoenix.Component

  def number_button(assigns) do
    col_span =
      case Map.get(assigns, :col_span) do
        nil -> ""
        number -> "col-span-#{number}"
      end
    ~H"""
    <div phx-click="number" phx-value-number={assigns.number} class={"bg-blue-50 border border-gray-50 shadow rounded-lg p-2 h-12 #{col_span}"}><%= assigns.number %></div>
    """
  end

  def operation_button(assigns) do
    IO.inspect assigns
    %{operation: operation, current_operation: current_operation} = assigns
    highlight =
      if (Map.get(assigns, :operation) == current_operation), do: "border-red-500"
    ~H"""
    <div phx-click="operation" phx-value-operation={operation} class={"bg-blue-50 border border-gray-50 shadow rounded-lg p-2 h-12 w-12 #{highlight}"}>
      <%= render_block(@inner_block) %>
    </div>
    """
  end
end
