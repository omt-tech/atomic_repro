defmodule AtomicRepro.Default.Atomic do
  use Ash.Resource,
    otp_app: :atomic_repro,
    domain: AtomicRepro.Default,
    extensions: [AshStateMachine],
    data_layer: AshPostgres.DataLayer

  state_machine do
    initial_states [:initialized]
    default_initial_state :initialized
    state_attribute :state

    transitions do
      # transition :reset_to_initialized, from: [:failed, :quality_assurance], to: :initialized
      # transition :start_upload, from: :initialized, to: :uploading
      # transition :poll_uploading, from: :uploading, to: :processing
      # transition :poll_processing_at_cesium, from: :processing, to: :archiving
      # transition :poll_archiving_at_cesium, from: :archiving, to: :downloading
      # transition :poll_downloading, from: :downloading, to: :quality_assurance
      transition :approve_quality, from: :initialized, to: :placeable
      # transition :mark_as_completed, from: :placeable, to: :complete
      # transition :*, from: [:uploading, :processing, :archiving], to: :failed
    end
  end

  postgres do
    table "atomics"
    repo AtomicRepro.Repo
  end

  actions do
    defaults [:read]

    update :approve_quality do
      # accept []
      # validate attribute_equals(:state, :quality_assurance)
      change transition_state(:placeable)
      change set_attribute(:approved, true)
    end
  end

  attributes do
    integer_primary_key :id

    attribute :approved, :boolean, public?: true
  end
end
