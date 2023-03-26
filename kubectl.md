# Kubernetes Commands

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

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
