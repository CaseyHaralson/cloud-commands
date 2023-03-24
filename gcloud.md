# Google Cloud Commands

https://cloud.google.com/sdk/gcloud/reference

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

## Compute

List the compute instances:

```
gcloud compute instances list
```

Create a new compute instance:

```
gcloud compute instances create [instance-name] --machine-type=[type] --zone=[zone]
```

Add tags:

```
gcloud compute instances add-tags [instance-name] --tags=[tag1,tag2]
```

SSH into a compute instance:

```
gcloud compute ssh [instance-name] --zone=[zone]
```

### Firewall

List and filter firewall rules:

```
gcloud compute firewall-rules list
gcloud compute firewall-rules list --filter="NETWORK:'[network-name]'"
gcloud compute firewall-rules list --filter="NETWORK:'[network-name]' AND ALLOW:'icmp'"
```

Create firewall rule:

```
gcloud compute firewall-rules create [rule-name] --target-tags=[tags] --allow=tcp:[port]

gcloud compute firewall-rules create [rule-name] \
--direction=INGRESS \
--priority=1000 \
--network=[network-name] \
--action=ALLOW \
--rules=tcp:[port] \
--source-ranges=[cidr-range] \
--target-tags=[tag1,tag2]
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
--region=region] \
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
--named-ports=[name:port] \
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

Create a cluster:

```
gcloud container clusters create --machine-type=[type] --zone=[zone] [cluster-name]
```

Get the cluster authentication credentials:

```
gcloud container clusters get-credentials [cluster-name] --zone=[zone]
```

Delete a cluster:

```
gcloud container clusters delete [cluster-name]
```
