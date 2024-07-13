## Repro result:

It tries to write the boolean to the state column!
```
iex(1)> AtomicRepro.run

11:09:13.701 [debug] QUERY OK source="atomics" db=1.2ms decode=0.5ms queue=0.6ms idle=1455.2ms
INSERT INTO "atomics" ("id","state","approved") VALUES ($1,$2,$3) ON CONFLICT ("id") DO UPDATE SET "id" = EXCLUDED."id","approved" = EXCLUDED."approved","state" = EXCLUDED."state" [1, :initialized, false]

11:09:13.788 [debug] QUERY ERROR source="atomics" db=2.1ms queue=0.8ms idle=1545.9ms
UPDATE "atomics" AS a0 SET "state" = (CASE WHEN (CASE WHEN a0."state"::varchar = ANY($1) OR $2::boolean THEN $3 ELSE ash_raise_error((jsonb_build_object('exception', $4::text, 'input', jsonb_build_object($5::text, $6::jsonb, $7::text, $8::jsonb, $9::text, a0."state"::varchar)))::jsonb) END) IS NULL THEN ash_raise_error($10::jsonb, $11::varchar) WHEN a0."state"::varchar = ANY($12) OR $13::boolean THEN $14::varchar ELSE ash_raise_error((jsonb_build_object('exception', $15::text, 'input', jsonb_build_object($16::text, $17::jsonb, $18::text, $19::jsonb, $20::text, a0."state"::varchar)))::jsonb, $21::varchar) END), "approved" = $22 WHERE (a0."id"::bigint = $23::bigint) [["initialized"], nil, "placeable", "AshStateMachine.Errors.NoMatchingTransition", "target", "placeable", "action", "approve_quality", "old_state", "{\"input\":{\"type\":\"attribute\",\"resource\":\"Elixir.AtomicRepro.Default.Atomic\",\"field\":\"state\"},\"exception\":\"Ash.Error.Changes.Required\"}", nil, ["initialized"], nil, :placeable, "AshStateMachine.Errors.NoMatchingTransition", "target", "placeable", "action", "approve_quality", "old_state", nil, true, 1]
%Ash.BulkResult{
  status: :error,
  errors: [
    %Ash.Error.Unknown{
      errors: [
        %Ash.Error.Unknown.UnknownError{
          error: "** (DBConnection.EncodeError) Postgrex expected a boolean, got \"placeable\". Please make sure the value you are passing matches the definition in your table or in your query or convert the value accordingly.",
          field: nil,
          value: nil,
          splode: Ash.Error,
          bread_crumbs: [],
          vars: [],
          path: [],
          stacktrace: #Splode.Stacktrace<>,
          class: :unknown
        }
      ]
    }
  ],
  records: nil,
  notifications: [],
  error_count: 1
}
iex(2)> 
```

