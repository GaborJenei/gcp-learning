#! /bin/bash

# Perform Foundational Infrastructure Tasks in Google Cloud: Challenge Lab
# us-east1 region and us-east1-b

export REGION=us-east1
export ZONE=us-east1-b

export BUCKET=memories-bucket-46072
export PUBSUB_TOPIC=memories-topic-331
export FUNCTION=memories-thumbnail-creator


# Task 1: Create a
gsutil mb gs://$BUCKET

# Task 2: Create a Pub/Sub topic
gcloud pubsub topics create $PUBSUB_TOPIC

# Task 3: Create the thumbnail Cloud Function
# Mainly manual
# TODO: work out how to do it from the shell
gcloud functions deploy --stage-bucket=STAGE_BUCKET \
--trigger-bucket=TRIGGER_BUCKET \
 $FUNCTION
