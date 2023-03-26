# Google Cloud Commands

https://cloud.google.com/sdk/gcloud/reference

## New Shell

Open a new Cloud Shell: https://shell.cloud.google.com/?show=terminal

List and then set the project for the shell:

```
gcloud projects list

gcloud config set project [project-id]
```

## Variables

Set and use a linux variable:

```
[variable]=[value]
echo $[variable]
```

## Auth

Check the list of authorized accounts:

```
gcloud auth list
```

## Config

Check the list of configured settings:

```
gcloud config list
```

Show the active configured project:

```
gcloud config list project
```

Get a config value:

```
gcloud config get-value [config-name]
```

Set the compute region & zone:

```
gcloud config set compute/region [region]
gcloud config set compute/zone [zone]
```

## VPC

List the VPC networks:

```
gcloud compute networks list
```

List the VPC subnets:

```
gcloud compute networks subnets list --sort-by=NETWORK
gcloud compute networks subnets list --network=[vpc-name]
```

Create a VPC:

```
gcloud compute networks create [vpc-name]
gcloud compute networks create [vpc-name] --subnet-mode=custom
```

Create a subnet:

```
gcloud compute networks subnets create [subnet-name] \
--network=[vpc-name] \
--region=[region] \
--range=[cidr-range]
```

### Firewall

List and filter firewall rules:

```
gcloud compute firewall-rules list --sort-by=NETWORK
gcloud compute firewall-rules list --filter="NETWORK:'[network-name]'"
gcloud compute firewall-rules list --filter="NETWORK:'[network-name]' AND ALLOW:'icmp'"
```

Create firewall rule:

```
gcloud compute firewall-rules create [rule-name] \
--allow=[tcp:[port],tcp:[port2],[protocol]]

gcloud compute firewall-rules create [rule-name] \
--target-tags=[tags] \
--allow=[tcp:[port],tcp:[port2],[protocol]]

gcloud compute firewall-rules create [rule-name] \
--direction=INGRESS \
--priority=1000 \
--network=[network-name] \
--action=ALLOW \
--rules=[tcp:[port],tcp:[port2],[protocol]] \
--source-ranges=[cidr-range] \
--target-tags=[tag1,tag2]
```

## Compute

List the compute instances:

```
gcloud compute instances list
```

Create a new compute instance:

```
gcloud compute instances create [instance-name] --machine-type=[type] --zone=[zone]

gcloud compute instances create [instance-name] \
--machine-type=[type] \
--zone=[zone] \
--subnet=[subnet-name]
```

Add tags:

```
gcloud compute instances add-tags [instance-name] --tags=[tag1,tag2]
```

SSH into a compute instance:

```
gcloud compute ssh [instance-name] --zone=[zone]
```

### Monitoring

Download and install the monitoring agent:

```
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh

sudo bash add-google-cloud-ops-agent-repo.sh --also-install
```

### Load Balancer

#### Regional Load Balancer

Create a static external IP address:

```
gcloud compute addresses create [ip-name] --region=[region]
```

Create a health check resource:

```
gcloud compute http-health-checks create [check-name]
```

Create a target pool:

```
gcloud compute target-pools create [pool-name] \
--region=[region] \
--http-health-check=[check-name]
```

Add instances to the target pool:

```
gcloud compute target-pools add-instances [pool-name] \
--instances=[instance-name1,instance-name2]
```

Create a forwarding rule:

```
gcloud compute forwarding-rules create [rule-name] \
--region=[region] \
--ports=[port] \
--address=[ip-name] \
--target-pool=[pool-name]
```

View data about the forwarding rule and the IP address:

```
gcloud compute forwarding-rules describe [rule-name] --region=[region]

gcloud compute forwarding-rules describe [rule-name] \
--region=[region] \
--format="json" | jq -r .IPAddress
```

#### HTTP(S) Load Balancer

Create a compute instance template:

```
gcloud compute instance-templates create [template-name] \
--region=[region] \
--network=[network] \
--subnet=[network] \
--tags=[tag1,tag2] \
--machine-type=[type] \
--image-family=debian-11 \
--image-project=debian-cloud \
--metadata=startup-script='[startup-script-content]'
```

Create a managed instance group from the template and set the named ports:

```
gcloud compute instance-groups managed create [group-name] \
--template=[template-name] \
--size=[size] \
--zone=[zone]

gcloud compute instance-groups managed set-named-ports [group-name] \
--named-ports=http:80 \
--zone=[zone]
```

Create a firewall rule:

```
gcloud compute firewall-rules create [rule-name] \
--network=[network] \
--action=allow \
--direction=ingress \
--source-ranges=130.211.0.0/22,35.191.0.0/16 \
--target-tags=[tags] \
--rules=tcp:80
```

Create and view a global static external IP address:

```
gcloud compute addresses create [ip-name] --ip-version=IPV4 --global

gcloud compute addresses describe [ip-name] --format="get(address)" --global
```

Create a health check:

```
gcloud compute health-checks create http [check-name] --port=80
```

Create a backend service:

```
gcloud compute backend-services create [service-name] \
--protocol=HTTP \
--port-name=http \
--health-checks=[check-name] \
--global
```

Add the instance group as the backend to the backend service:

```
gcloud compute backend-services add-backend [service-name] \
--instance-group=[group-name] \
--instance-group-zone=[zone] \
--global
```

Create a URL map to route requests from the load balancer to the backend service:

```
gcloud compute url-maps create [map-name] --default-service=[service-name]
```

Create a HTTP proxy to route requests to the URL map:

```
gcloud compute target-http-proxies create [proxy-name] --url-map=[map-name]
```

Create a forwarding rule:

```
gcloud compute forwarding-rules create [rule-name] \
--address=[ip-name] \
--global \
--target-http-proxy=[proxy-name] \
--ports=80
```

## Kubernetes Engine

kubectl commands: [kubectl.md](./kubectl.md)

Create a cluster:

```
gcloud container clusters create [cluster-name] --machine-type=[type] --zone=[zone]
gcloud container clusters create [cluster-name] --machine-type=[type] --region=[region]

gcloud container clusters create [cluster-name] \
--machine-type=[type] \
--zone=[zone] \
--num-nodes=[num] \
--network=[network] \
--subnetwork=[subnetwork]
```

Get the cluster authentication credentials:

```
gcloud container clusters get-credentials [cluster-name] --zone=[zone]
```

Delete a cluster:

```
gcloud container clusters delete [cluster-name]
```

## Storage

https://cloud.google.com/storage/docs/gsutil

Create a new bucket:

```
gsutil mb gs://[bucket-name]
```

List the contents of a bucket:

```
gsutil ls gs://[bucket-name]
```

Copy a file to a bucket:

```
gsutil cp [file] gs://[bucket-name]
gsutil cp [file] gs://[bucket-name]/[folder]
```

Download a file or directory from a bucket:

```
gsutil cp gs://[bucket-name]/[file] .

gsutil cp -r gs://[bucket-name]/[folder] .
```

Make a file publicly accessible or remove public access through an ACL:

```
gsutil acl ch -u AllUsers:R gs://[bucket-name]/[file]

gsutil acl ch -d AllUsers gs://[bucket-name]/[file]
```

Remove a file from a bucket:

```
gsutil rm gs://[bucket-name]/[file]
```

## Functions

First, create a storage bucket to store the function code. Second, create a local directory with the function source code in it and change to that directory.

Deploy the current directory as a function that will trigger from a Pub/Sub topic and then test the function:

```
gcloud functions deploy [function-name] \
--stage-bucket=[bucket-name] \
--trigger-topic=[topic-name]
--runtime=[code-runtime]

DATA=$(printf 'Hello World!'|base64) && gcloud functions call [function-name] \
--data='{"data":"'$DATA'"}'
```

View the details about a function:

```
gcloud functions describe [function-name]
```

View the logs from a function:

```
gcloud functions logs read [function-name]
```

## Pub/Sub

List the existing topics:

```
gcloud pubsub topics list
```

Create a topic:

```
gcloud pubsub topics create [topic-name]
```

Delete a topic:

```
gcloud pubsub topics delete [topic-name]
```

List the subscriptions to a topic:

```
gcloud pubsub topics list-subscriptions [topic-name]
```

Create a subscription to a topic:

```
gcloud pubsub subscriptions create --topic=[topic-name] [subscription-name]
```

Delete a subscription to a topic:

```
gcloud pubsub subscriptions delete [subscription-name]
```

Publish a message to a topic:

```
gcloud pubsub topics publish [topic-name] --message="[message]"
```

Pull a message from a subscription:

```
gcloud pubsub subscriptions pull [subscription-name]
gcloud pubsub subscriptions pull [subscription-name] --auto-ack
gcloud pubsub subscriptions pull [subscription-name] --auto-ack --limit=3
```

## Cloud SQL

Connect to a server:

```
gcloud sql connect [server-name] --user=[user] --quiet
```
