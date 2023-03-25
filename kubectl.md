# Kubernetes Commands

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

## Info

```
kubectl cluster-info

kubectl config view

kubectl get events

kubectl logs [pod-name]
```

## Deployments

List the deployments:

```
kubectl get deployments
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

## Pods

List the pods or get more information about a pod:

```
kubectl get pods

kubectl describe pods [pod-name]
```

## Services

List all services:

```
kubectl get service
```

Expose a deployment:

```
kubectl expose deployment [deployment-name] --type=LoadBalancer --port=[port]
```
