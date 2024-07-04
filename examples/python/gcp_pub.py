#!/usr/bin/env python3
from google.cloud import pubsub_v1

# https://cloud.google.com/pubsub/docs/publish-receive-messages-client-library

# https://cloud.google.com/docs/authentication/provide-credentials-adc#how-to
# gcloud auth application-default login

project_id = "slopesai-pubsub"
topic_id = "callforhelp"

# Example, I was snowboarding here at 37.630262, -119.030528
# https://www.google.com/maps/place/Mammoth+Lakes,+CA+93546/@37.6266943,-119.0275364,715a,35y,313.95h,35.21t/data=!3m1!1e3!4m6!3m5!1s0x80960c5f79b3179f:0xf114d9d70fee8d6d!8m2!3d37.648546!4d-118.972079!16zL20vMHIxd3o?entry=ttu

def main(args = None) -> None:
  publisher = pubsub_v1.PublisherClient()
  # The `topic_path` method creates a fully qualified identifier
  # in the form `projects/{project_id}/topics/{topic_id}`
  topic_path = publisher.topic_path(project_id, topic_id)

  for n in range(1, 10):
      data_str = f"I'm injured, pls send help.  Coordinates: 37.630262, -119.030528  Message: {n}"
      
      # Data must be a bytestring
      data = data_str.encode("utf-8")

      # When you publish a message, the client returns a future.
      future = publisher.publish(topic_path, data)

      print(future.result())

  print(f"Published messages to {topic_path}.")


if __name__ == "__main__":
    main()
