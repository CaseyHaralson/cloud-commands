# Kubernetes Commands

Command reference: https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

## Info

```
kubectl cluster-info

kubectl config view

kubectl get events

kubectl logs [pod-name]
kubectl logs -f [pod-name]

kubectl explain deployment
kubectl explain deployment.metadata.name
kubectl explain deployment --recursive
```

## Yaml Config Files

Create something from a configuration file:

```
kubectl create -f [yaml-file]
```

## Volumes

Create a secret volume from a folder/file:

```
kubectl create secret generic [volume-name] --from-file [folder]/
kubectl create secret generic [volume-name] --from-file [folder/file]
kubectl create secret generic [volume-name] --from-file [file]
```

Create a configmap volume from a folder/file:

```
kubectl create configmap [volume-name] --from-file [folder]/
kubectl create configmap [volume-name] --from-file [folder/file]
kubectl create configmap [volume-name] --from-file [file]
```

## Deployments

List the deployments or get more information about a deployment:

```
kubectl get deployments
kubectl get deployments [deployment-name]

kubectl describe deployments [deployment-name]
```

Create a deployment:

```
kubectl create deployment [deployment-name] --image=[image-location]
kubectl create deployment [deployment-name] --image=gcr.io/google-samples/hello-app:1.0
```

Scale a deployment:

```
kubectl scale deployment [deployment-name] --replicas=[num]
```

Edit a deployment, pause a rollout, resume a rollout, rollback a rollout, and get the status of the deployment and pods:

```
kubectl edit deployment [deployment-name]

kubectl rollout pause deployment/[deployment-name]

kubectl rollout resume deployment/[deployment-name]

kubectl rollout undo deployment/[deployment-name]

kubectl rollout status deployment/[deployment-name]
kubectl rollout history deployment/[deployment-name]

kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'
```

## Pods

List the pods or get more information about a pod:

```
kubectl get pods
kubectl get pods [pod-name]
kubectl get pods -l "[label1,label2]"

kubectl describe pods [pod-name]
```

Create a port-forward for a pod for testing locally and then use another terminal to connect to the pod:

```
kubectl port-forward [pod-name] [machine-port]:[pod-port]

curl http://127.0.0.1:[machine-port]
```

Connect to an interactive shell in a pod:

```
kubectl exec [pod-name] --stdin --tty -c [container-name] -- /bin/sh
```

## Services

List the services or get more information about a service:

```
kubectl get services
kubectl get services [service-name]

kubectl describe services [service-name]
```

Expose a deployment:

```
kubectl expose deployment [deployment-name] --type=LoadBalancer --port=[port]
```

## Namespaces

List the namespaces or get a list of some resource by namespace:

```
kubectl get namespace

kubectl get pods --namespace=[namespace]
kubectl get services --namespace=[namespace]
```

Create a new namespace:

```
kubectl create namespace [namespace]
```

Set the context namespace so you don't need to specify it in commands or set it back to default:

```
kubectl config set-context --current --namespace=[namespace]

kubectl config set-context --current --namespace=default
```

### RBAC

After giving the IAM role `roles/container.clusterViewer` to a principal, their access can be controlled by Kubernetes RBAC.

Kubernetes roles can be created with commands, but will most likely be created in configuration files and limited to namespaces:

```
kubectl create role [role-name] \
--resource=[resource] \
--verb=[verb1] --verb=[verb2]

kubectl create role pod-reader \
--resource=pods \
--verb=watch --verb=get --verb=list
```

Bind a role to a user:

```
kubectl create rolebinding [rolebinding-name] \
--role=[role-name] \
--user=[user]
```

### Quotas

List the quotas or describe a quota for a certain namespace:

```
kubectl get quota --namespace=[namespace]

kubectl describe quota [quota-name] --namespace=[namespace]
```

Create a quota for a namespace:

```
kubectl create quota [quota-name] \
--hard=count/[type1]=[num1],count/[type2]=[num2] \
--namespace=[namespace]
```

Open an editor (vim) and edit a quota for a namespace:

```
kubectl edit quota [quota-name] --namespace=[namespace]
```
