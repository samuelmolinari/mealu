defmodule Mealu.ErrorView do
  use Mealu.Web, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("invalid.json", %{changeset: changeset}) do
    %{errors: %{invalid: render_changeset_errors_json(changeset.errors)}}
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end

  def render_changeset_errors_json(errors) do
    Enum.map errors, fn {field, detail} ->
      %{field: field, message: render_details_json(detail)}
    end
  end

  def render_details_json({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  def render_details_json(message), do: message
end
