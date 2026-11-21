# GitOps with Argo CD

Argo CD compares a Git branch with the running app. **Sync** applies the Git version.

## Set up a team sandbox

From a checkout of your public workshop fork, create and push the lab branch:

```sh
git switch -c argocd-demo
git push -u origin argocd-demo
```

Use [kind v0.33.0](https://github.com/kubernetes-sigs/kind/releases/tag/v0.33.0) and Docker on a machine where you can create a disposable cluster. A team member with cluster admin access runs the setup.

```sh
kind create cluster --name workshop-argocd
kubectl --context kind-workshop-argocd create namespace argocd
kubectl --context kind-workshop-argocd create namespace argocd-demo
kubectl --context kind-workshop-argocd -n argocd apply --server-side \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/v3.6.2/manifests/install.yaml
kubectl --context kind-workshop-argocd -n argocd rollout status deployment/argocd-server --timeout=3m
```

From this chapter's directory, set both Git URLs in `application.yaml` to your fork URL and apply it. The project limits the application to your fork and the `argocd-demo` namespace.

```sh
kubectl --context kind-workshop-argocd apply -f application.yaml
kubectl --context kind-workshop-argocd -n argocd get secret argocd-initial-admin-secret \
  -o 'go-template={{.data.password | base64decode}}{{"\n"}}'
kubectl --context kind-workshop-argocd -n argocd port-forward svc/argocd-server 8080:443
```

Open [the local dashboard](https://localhost:8080) and sign in as `admin` with the password above. The sandbox uses a self-signed certificate.

## Sync, update, revert

1. Select **workshop-web → Sync → Synchronize**. Wait for **Synced** and **Healthy**.
2. Change the image tag in `app/deployment.yaml` from `1.30.1-alpine` to `1.30.2-alpine`. Run `git add app/deployment.yaml && git commit -m "Update web image" && git push`.
3. Refresh the app. It should show **OutOfSync**. Sync and check the new image:

   ```sh
   kubectl --context kind-workshop-argocd -n argocd-demo get deploy workshop-web \
     -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
   ```

4. Run `git revert --no-edit HEAD && git push`. Refresh and sync again. The image returns to `1.30.1-alpine`.
5. Stop port forwarding and run `kind delete cluster --name workshop-argocd`.
