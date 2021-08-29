defmodule BlogWeb.CalculatorLive.Index do
  use BlogWeb, :live_view
  import BlogWeb.CalculatorComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{result: "0", operation: nil, refresh: false})}
  end

  def handle_event("calculate", %{"cal" => params}, socket) do
    IO.inspect params
    %{"first" => first, "second" => second} = params
    result = String.to_integer(first) + String.to_integer(second)
    {:noreply, assign(socket, :result, result)}
  end

  def handle_event("number", %{"number" => number}, socket) do
    result = socket.assigns.result
    case socket.assigns.refresh do
      true ->
        {:noreply, assign(socket, %{result: number, subject: result, refresh: false})}
      _ ->
        {:noreply, assign(socket, :result, add_digit(result, number))}
    end
  end

  defp add_digit(result, number) do
    case result do
      "0" -> number
      _ -> result <> number
    end
  end

  def handle_event("operation", %{"operation" => operation}, socket) do
    {:noreply, assign(socket, %{operation: operation, refresh: true})}
  end

  def handle_event("calculate", _params, socket) do
    %{subject: subject, result: mutate, operation: operation} = socket.assigns
    subject = String.to_integer(subject)
    mutate = String.to_integer(mutate)
    result =
      case operation do
        "/" ->
          div(subject, mutate)
        "*" ->
          subject * mutate
        "-" ->
          subject - mutate
        "+" ->
          subject + mutate
        _ ->
          "error"
      end
    {:noreply, assign(socket, %{result: result, operation: nil})}
  end
end
