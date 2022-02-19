#! /bin/bash

# remove python 3.9
sudo apt remove python python3 python3.9
sudo apt autoremove



# Pull down Python 3.7, build, and install
wget https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tar.xz
tar xvf Python-3.7.12.tar.xz
cd /tmp/Python37/Python-3.7.12
./configure
sudo make altinstall

# Create virtualenv
cd ~
virtualenv -p python3.7 env
source env/bin/activate
pip install apache-beam[gcp]

# un the wordcount.py example locally
python -m apache_beam.examples.wordcount --output OUTPUT_FILE


# Run an Example Pipeline Remotely

export BUCKET=gs://qwiklabs-gcp-01-a59b6ed5572d

python -m apache_beam.examples.wordcount --project $DEVSHELL_PROJECT_ID \
  --runner DataflowRunner \
  --staging_location $BUCKET/staging \
  --temp_location $BUCKET/temp \
  --output $BUCKET/results/output \
  --region us-central1
