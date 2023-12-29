resource "google_pubsub_topic" "google_pubsubtopic" {
  name = "pub-sub-topic"
}

resource "google_pubsub_subscription" "google-pub-sub-subscription" {
  name = "pub-sub-subscription"
  topic = google_pubsub_topic.google_pubsubtopic.name
}