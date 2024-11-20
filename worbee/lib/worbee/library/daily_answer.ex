defmodule Worbee.Library.DailyAnswer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_answers" do
    field :date, :date
    field :word, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(daily_answer, attrs) do
    daily_answer
    |> cast(attrs, [:word, :date])
    |> validate_required([:word, :date])
  end
end
