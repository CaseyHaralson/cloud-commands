# Google Cloud Commands

Command reference: https://cloud.google.com/sdk/gcloud/reference

## Install gcloud SDK

Install instructions: https://cloud.google.com/sdk/docs/install

Authorization instructions: https://cloud.google.com/sdk/docs/authorizing

### Rapid Install

If you are on linux and have python installed, you can install the cloud SDK to your local user's account by running the following and accepting the defaults (by pressing ENTER when asked):

```
curl https://sdk.cloud.google.com | bash
```

Then reload the shell:

```
exec -l $SHELL
```

Authenticate with or without a browser on the computer:

```
gcloud auth login
gcloud auth login --no-launch-browser
```

### Installed Components

Check for installed components and install a new component:

```
gcloud components list

gcloud components install [component]
```

## New Cloud Shell

Open a new Cloud Shell with gcloud SDK already installed: https://shell.cloud.google.com/?show=terminal

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

Authorize against another account (with or without a browser on the computer), then select to create a new configuration after running the command:

```
gcloud init
gcloud init --no-launch-browser
```

Switch between different configured auth profiles:

```
gcloud config configurations activate [profile-name]
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

View the configuration file:

```
cat ~/.config/gcloud/configurations/config_default
```

## IAM

IAM permissions reference: https://cloud.google.com/iam/docs/permissions-reference

Create a new role at the project level:

```
gcloud iam roles create [role-name] \
--project=[project-id] \
--permissions="[permission1,permission2]"
```

Add a new role to a user at the project level:

```
gcloud projects add-iam-policy-binding [project-id] --member=user:[user-id] --role=[role]
```

Create a service account:

```
gcloud iam service-accounts create [service-account-name] --display-name=[display-name]
```

Add a new role to a service account at the project level:

```
gcloud projects add-iam-policy-binding [project-id] \
--member=serviceAccount:[service-account-id] \
--role=[role]
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

gcloud compute instances create [instance-name] \
--machine-type=[type] \
--tags=[tag1,tag2] \
--metadata=startup-script-url=[url]
```

Add tags:

```
gcloud compute instances add-tags [instance-name] --tags=[tag1,tag2]
```

SSH into a compute instance:

```
gcloud compute ssh [instance-name] --zone=[zone]
```

Stop, start, or delete a compute instance:

```
gcloud compute instances stop [instance-name]

gcloud compute instances start [instance-name]

gcloud compute instances delete [instance-name]
```

### Monitoring

Download and install the monitoring agent:

```
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh

sudo bash add-google-cloud-ops-agent-repo.sh --also-install
```

### Managed Instance Group

List the instance templates and instance groups:

```
gcloud compute instance-templates list

gcloud compute instance-groups list-instances
gcloud compute instance-groups list-instances [group-name]
```

Create an instance template from a stopped, source compute instance:

```
gcloud compute instance-templates create [template-name] --source-instance=[instance-name]
```

Create an instance template from a definition:

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

Create a managed instance group from a template:

```
gcloud compute instance-groups managed create [group-name] \
--base-instance-name=[instance-name-prefix] \
--size=[size] \
--template=[template-name]
```

Set any named ports for the instance group:

```
gcloud compute instance-groups set-named-ports [group-name] \
--named-ports=[name1:port1,name2:port2]
```

Create an autohealing health check for an instance group:

```
gcloud compute health-checks create http [check-name] \
--port=[port] \
--request-path=[request-path] \
--check-interval=30s \
--healthy-threshold=1 \
--timeout=10s \
--unhealthy-threshold=3
```

Apply the health check to the instance group:

```
gcloud compute instance-groups managed update [group-name] \
--health-check=[check-name] \
--initial-delay=300
```

Create a firewall rule to allow the health checks:

```
gcloud compute firewall-rules create [rule-name] \
--allow=tcp:[port-range] \
--source-ranges=130.211.0.0/22,35.191.0.0/16 \
--network=[network]
```

Set the autoscaling policy on an instance group:

```
gcloud compute instance-groups managed set-autoscaling [group-name] \
--max-num-replicas=[num] \
--target-load-balancing-utilization=0.60
```

#### Updates

Update a managed instance group with a new template:

```
gcloud compute instance-groups managed rolling-action start-update [group-name] \
--version=template=[template-name]
```

Apply a rolling update to the managed instance group (like if they reference a startup script and the startup script changed), and for development set the max unavailable to 100 so they all replace immediately:

```
gcloud compute instance-groups managed rolling-action replace [group-name]

gcloud compute instance-groups managed rolling-action replace [group-name] \
--max-unavailable=100%
```

### Load Balancer

#### Regional Load Balancer

Create a static external IP address:

```
gcloud compute addresses create [ip-name] --region=[region]
```

Create a health check resource:

```
gcloud compute health-checks create http [check-name]
```

Create a target pool:

```
gcloud compute target-pools create [pool-name] \
--region=[region] \
--health-check=[check-name]
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

First, create a managed instance group and set any needed named ports: [manged instance groups](#managed-instance-group)

Create a health check for load balancing:

```
gcloud compute health-checks create http [check-name] --port=80

gcloud compute health-checks create http [check-name] \
--request-path=[api-path] \
--port=[port]
```

Create a firewall rule if needed:

```
gcloud compute firewall-rules create [rule-name] \
--network=[network] \
--action=allow \
--direction=ingress \
--source-ranges=130.211.0.0/22,35.191.0.0/16 \
--target-tags=[tags] \
--rules=tcp:80
```

Create a backend service:

```
gcloud compute backend-services create [service-name] \
--protocol=HTTP \
--port-name=[named-port] \
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

Update a URL map to route requests to non-default backend services:

```
gcloud compute url-maps add-path-matcher [map-name] \
--default-service=[default-service-name] \
--path-matcher-name=[matcher-name] \
--path-rules="[api-path1=service-name1,api-path2=service-name2]"
```

Create a HTTP proxy to route requests to the URL map:

```
gcloud compute target-http-proxies create [proxy-name] --url-map=[map-name]
```

Create a global static external IP address if you don't want the forwarding-rule to create it and then view the IP address:

```
gcloud compute addresses create [ip-name] --ip-version=IPV4 --global

gcloud compute addresses describe [ip-name] --format="get(address)" --global
```

Create a forwarding rule with or without a previously created IP address:

```
gcloud compute forwarding-rules create [rule-name] \
--address=[ip-name] \
--global \
--target-http-proxy=[proxy-name] \
--ports=80

gcloud compute forwarding-rules create [rule-name] \
--global \
--target-http-proxy=[proxy-name] \
--ports=80
```

View the IP addresses of any forwarding rules:

```
gcloud compute forwarding-rules list --global
```

Enable a CDN:

```
gcloud compute backend-services update [backend-service-name] --enable-cdn --global
```

## Kubernetes Engine

kubernetes command reference: [kubectl.md](./kubectl.md)

Create a cluster:

- enable-ip-alias = allows for container native load balancing (instead of having to use iptables inside the nodes)
- release-channel = how fast new Kubernetes versions are available (the default is regular)

```
gcloud container clusters create [cluster-name] --machine-type=[type] --zone=[zone]
gcloud container clusters create [cluster-name] --machine-type=[type] --region=[region]

gcloud container clusters create [cluster-name] \
--machine-type=[type] \
--zone=[zone] \
--num-nodes=[num] \
--network=[network] \
--subnetwork=[subnetwork] \
--enable-ip-alias \
--release-channel=[rapid/regular/stable]
```

Get the cluster authentication credentials:

```
gcloud container clusters get-credentials [cluster-name] --zone=[zone]
```

Delete a cluster:

```
gcloud container clusters delete [cluster-name]
```

### Node Pool

Create a node pool:

```
gcloud container node-pools create [node-pool-name] \
--cluster=[cluster-name] \
--machine-type=[type] \
--num-nodes=[num] \
--zone=[zone]
```

Change a node pool's size:

```
gcloud container clusters resize [cluster-name] \
--node-pool=[node-pool-name] \
--num-nodes=[num] \
--zone=[zone]
```

Delete a node pool:

```
gcloud container node-pools delete [node-pool-name] \
--cluster=[cluster-name] \
--zone=[zone]
```

### Autoscaling and Autoprovisioning

Create a cluster with vertical pod autoscaling enabled:

```
gcloud container clusters create [cluster-name] \
--num-nodes=[num] \
--enable-vertical-pod-autoscaling
```

Update a cluster and add cluster autoscaling:

```
gcloud beta container clusters update [cluster-name] \
--enable-autoscaling \
--min-nodes=[min] \
--max-nodes=[max] \
--autoscaling-profile=[balanced/optimize-utilization]
```

Update a cluster and add autoprovisioning:

```
gcloud container clusters update [cluster-name] \
--enable-autoprovisioning \
--min-cpu=[min-cpu] \
--min-memory=[min-memory] \
--max-cpu=[max-cpu] \
--max-memory=[max-memory]
```

## Storage

gsutil command reference: https://cloud.google.com/storage/docs/gsutil

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

Copy a source to a destination without overwriting (-n) and/or with multi-threading (-m):

```
gsutil cp -n [source] [destination]

gsutil -m cp [source] [destination]
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
