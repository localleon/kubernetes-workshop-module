# GitOps with Rancher Fleet

Fleet watches a Git path and applies the Kubernetes manifests it finds there. The instructor runs this demo because the Fleet management namespace is shared.

```sh
kubectl apply -f fleet-resources/gitrepo-simple.yaml
kubectl get gitrepo -n fleet-local sample-simple
kubectl get pods -n fleet-sample-simple
```

In Rancher, open **Continuous Delivery** and find `sample-simple`. Check its revision and sync status. The manifest points to the workshop's main branch. To try a change, point it at an instructor-controlled fork, change the replica count in Git, and watch Fleet reconcile it.

```sh
kubectl delete -f fleet-resources/gitrepo-simple.yaml
```
