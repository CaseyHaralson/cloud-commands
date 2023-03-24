# Kubernetes Commands

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

## Display

List all services:

```
kubectl get service
```

## Deployment

Create a deployment:

```
kubectl create deployment [deployment-name] --image=[image-location]
kubectl create deployment [deployment-name] --image=gcr.io/google-samples/hello-app:1.0
```

## Service

Expose a deployment:

```
kubectl expose deployment [deployment-name] --type=LoadBalancer --port [port]
```
