# Google Cloud Pub/Sub: Qwik Start - Command Line

#!/usr/bin/env bash


# Pub/Sub comes preinstalled in the Google Cloud Shell, so there are no installations or configurations required to get started with this service.
# Run the following command to create a topic called myTopic:
gcloud pubsub topics create myTopic

gcloud pubsub topics create Test1
gcloud pubsub topics create Test2

# To see list of topics
gcloud pubsub topics list

# delete topics
gcloud pubsub topics delete Test1
gcloud pubsub topics delete Test2

# See list of topics again
gcloud pubsub topics list

#
# Pub/Sub subscriptions
#

# create a subscription called mySubscription to topic myTopic
gcloud pubsub subscriptions create --topic myTopic mySubscription


gcloud pubsub subscriptions create --topic myTopic Test1
gcloud pubsub subscriptions create --topic myTopic Test2

# list the subscriptions to myTopic:
gcloud pubsub topics list-subscriptions myTopic

# delete the Test1 and Test2 subscriptions
gcloud pubsub subscriptions delete Test1
gcloud pubsub subscriptions delete Test2

# list the subscriptions to myTopic:
gcloud pubsub topics list-subscriptions myTopic

#
# Pub/Sub Publishing and Pulling a Single Message
#

# following command to publish the message "hello" to the topic you created previously (myTopic)
gcloud pubsub topics publish myTopic --message "Hello"

gcloud pubsub topics publish myTopic --message "Publisher's name is Gabor"
gcloud pubsub topics publish myTopic --message "Publisher likes to eat kebab"
gcloud pubsub topics publish myTopic --message "Publisher thinks Pub/Sub is awesome"

# use the pull command to get the messages from your topic.
# The pull command is subscription based, meaning it should work because earlier you set up the subscription mySubscription to the topic myTopic
gcloud pubsub subscriptions pull mySubscription --auto-ack

# important time to note a couple features of the pull command that often trip developers up:
#  - Using the pull command without any flags will output only one message,
#    even if you are subscribed to a topic that has more held in it.
#  - Once an individual message has been outputted from a particular
#    subscription-based pull command, you cannot access that message again with
#    the pull command.


#
# Pub/Sub pulling all messages from subscriptions
#

# Since you pulled all of the messages from your topic in hte last example, populate myTopic with a few more messages
gcloud pubsub topics publish myTopic --message "Publisher is starting to get the hang of Pub/Sub"
gcloud pubsub topics publish myTopic --message "Publisher wonders if all messages will be pulled"
gcloud pubsub topics publish myTopic --message "Publisher will have to test to find out"

# Add a flag to your command so you can output all three messages in one request.
gcloud pubsub subscriptions pull mySubscription --auto-ack --limit=3
