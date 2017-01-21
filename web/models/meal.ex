defmodule Mealu.Meal do
  use Mealu.Web, :model

  schema "meals" do
    field :serves, :integer
    field :due_at, :naive_datetime
    field :date, :string, virtual: true
    field :time, :string, virtual: true
    belongs_to :recipe, Mealu.Recipe

    timestamps()
  end

  def meal_time(date, time) when is_binary(date) do
    case Date.from_iso8601(date) do
      {:ok, date} -> meal_time(date, time)
      {:error, error} -> {:error, error}
    end
  end

  def meal_time(nil, _time),       do: {:error, :missing_date}
  def meal_time(date, :breakfast), do: NaiveDateTime.new(date, ~T[07:00:00])
  def meal_time(date, :lunch),     do: NaiveDateTime.new(date, ~T[12:00:00])
  def meal_time(date, :dinner),    do: NaiveDateTime.new(date, ~T[18:00:00])
  def meal_time(_date, _time),     do: {:error, :unknown_meal_time}

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:serves, :date, :time])
    |> put_due_at
    |> validate_required([:serves, :due_at])
    |> cast_assoc(:recipe)
  end

  defp put_due_at(changeset = %{changes: %{date: date, time: time}}) do
    case meal_time(date, String.to_atom(time)) do
      {:ok, due_at} ->
        changeset
        |> put_change(:due_at, due_at)
      {:error, message} ->
        changeset
        |> add_error(:date, "invalid")
    end
  end
  defp put_due_at(changeset), do: changeset
end
