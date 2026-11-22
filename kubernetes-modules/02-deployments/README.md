# Deployments

A Deployment creates ReplicaSets and manages Pod rollouts. Use the team namespace selected in the [intro](../00-intro).

Create one Deployment with a command and one from YAML.

```sh
kubectl create deployment nginx-deploy --image=ghcr.io/nginx/nginx-unprivileged:1.30.7-alpine --replicas=2
kubectl apply -f deployment.yaml
kubectl get deployments,replicasets,pods
```

Scale the first Deployment. In `deployment.yaml`, set `spec.replicas` to 3, then reapply it to scale the second.

```sh
kubectl scale deployment/nginx-deploy --replicas=4
kubectl apply -f deployment.yaml
kubectl get deployments
```

Update one image and watch the rollout.

```sh
kubectl set image deployment/declarative-deploy nginx=ghcr.io/nginx/nginx-unprivileged:1.30.7-alpine
kubectl rollout status deployment/declarative-deploy --timeout=120s
kubectl delete deployment nginx-deploy declarative-deploy
```

Optional exercise: [Deploy the Python image you built](python/README.md).
