# Gateway and REST

## Gateway overview

`Gateway` is split into:

- `GatewayManager` for shard orchestration
- `Shard` for per-shard lifecycle and protocol handling
- reconnect and heartbeat policy objects
- typed payload/opcode modeling

Current capabilities include:

- shard startup and shutdown
- heartbeat loops
- sequence tracking
- reconnect with backoff
- dispatch routing for ready and message-create events

## REST overview

`RESTClient` is actor-isolated and includes:

- route-based requests
- per-bucket request queueing
- rate-limit wait/update flow
- retry and backoff policy for retryable statuses

## Production tuning knobs

- `GatewayReconnectPolicy`
  - max attempts
  - base delay
  - max delay
- `RESTRetryPolicy`
  - max retries
  - retryable status codes
  - base/max backoff

## Extending transport layers

- add concrete websocket transport in `Gateway`
- add multipart request support in `RESTClient`
- add global rate-limit buckets
- add structured decode models for common dispatch payloads
