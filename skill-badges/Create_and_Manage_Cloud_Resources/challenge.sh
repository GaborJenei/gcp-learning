#! /bin/bash

export ZONE=us-east1-b

# Challenge 1
gcloud compute instances create nucleus-jumphost-435 \
    --machine-type f1-micro \
    --zone $ZONE

# Challenge 2
gcloud container clusters create nucleus-cluster --zone $ZONE
gcloud container clusters get-credentials nucleus-cluster --zone $ZONE

kubectl create deployment nucleus-server --image=gcr.io/google-samples/hello-app:2.0
kubectl expose deployment nucleus-server --type=LoadBalancer --port 8083

# Challenge 3 set up an HTTP Load balancer
cat << EOF > startup.sh
    #! /bin/bash
    apt-get update
    apt-get install -y nginx
    service nginx start
    sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
    EOF
'

gcloud compute instance-templates create nucleus-backend-template \
   --region=us-east1 --network=default --subnet=default --tags=allow-health-check \
   --image-family=debian-9 --image-project=debian-cloud \
   --metadata-from-file=startup-script=./startup.sh


gcloud compute instance-groups managed create nucleus-backend-group --template=nucleus-backend-template --size=2 --zone=us-east1-b


gcloud compute firewall-rules create permit-tcp-rule-705 \
    --network=default \
    --action=allow \
    --direction=ingress \
    --source-ranges=130.211.0.0/22,35.191.0.0/16 \
    --target-tags=allow-health-check \
    --rules=tcp:80

gcloud compute addresses create nucleus-ipv4-1 --ip-version=IPV4 --global

gcloud compute health-checks create http http-basic-check --port 80

gcloud compute backend-services create web-backend-service \
    --protocol=HTTP \
    --port-name=http \
    --health-checks=http-basic-check \
    --global

gcloud compute backend-services add-backend web-backend-service \
    --instance-group=nucleus-backend-group \
    --instance-group-zone=us-east1-b \
    --global

gcloud compute url-maps create web-map-http \
    --default-service web-backend-service

gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http

gcloud compute forwarding-rules create http-content-rule \
    --address=nucleus-ipv4-1\
    --global \
    --target-http-proxy=http-lb-proxy \
    --ports=80



gcloud compute instance-groups managed set-named-ports nucleus-backend-group \
        --named-ports=http:80
