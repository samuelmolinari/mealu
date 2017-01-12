defmodule Mealu.PageController do
  use Mealu.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
