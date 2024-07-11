#!/usr/bin/env python3
from concurrent.futures import TimeoutError
from google.cloud import pubsub_v1

# https://cloud.google.com/pubsub/docs/publish-receive-messages-client-library

# https://cloud.google.com/docs/authentication/provide-credentials-adc#how-to
# gcloud auth application-default login

project_id = "slopesai-pubsub"
subscription_id = "callforhelp-sub"
# Number of seconds the subscriber should listen for messages
timeout = 30.0


def main(args = None) -> None:
  subscriber = pubsub_v1.SubscriberClient()
  # The `subscription_path` method creates a fully qualified identifier
  # in the form `projects/{project_id}/subscriptions/{subscription_id}`
  subscription_path = subscriber.subscription_path(project_id, subscription_id)

  def callback(message: pubsub_v1.subscriber.message.Message) -> None:
      msgstr = str(message.data, 'UTF-8')
      print(f"Received {msgstr}.")
      message.ack()

  streaming_pull_future = subscriber.subscribe(subscription_path, callback=callback)
  print(f"Listening for messages on {subscription_path}..\n")

  # Wrap subscriber in a 'with' block to automatically call close() when done.
  with subscriber:
      try:
          # When `timeout` is not set, result() will block indefinitely,
          # unless an exception is encountered first.
          streaming_pull_future.result(timeout=timeout)
      except TimeoutError:
          streaming_pull_future.cancel()  # Trigger the shutdown.
          streaming_pull_future.result()  # Block until the shutdown is complete.


if __name__ == "__main__":
    main()
