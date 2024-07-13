defmodule AtomicRepro.Default do
  use Ash.Domain

  resources do
    resource AtomicRepro.Default.Atomic
  end
end
