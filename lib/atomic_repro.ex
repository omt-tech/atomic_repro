defmodule AtomicRepro do
  @moduledoc """
  Documentation for `AtomicRepro`.
  """

  alias AtomicRepro.Repo
  alias AtomicRepro.Default.Atomic
  require Ash.Query

  def run do
    {1, nil} =
      Repo.insert_all(Atomic, [%{id: 1, state: :initialized, approved: false}],
        on_conflict: :replace_all,
        conflict_target: [:id]
      )

    Atomic
    |> Ash.Query.filter(id == 1)
    |> Ash.bulk_update(:approve_quality, %{})
  end
end
