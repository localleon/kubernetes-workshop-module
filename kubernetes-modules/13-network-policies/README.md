# network-policies

* Deny all traffic to web-application

```
kubectl apply -f deny-all.yaml
```

* Start a busybox container pod in another namespace **in a different shell**

```
kubectl create namespace <YOUR_NAME>-policy
kubectl run -n <YOUR_NAME>-policy -it --image busybox network-policy-test -- sh

# In the pod: Try to reach your web-application
wget web-application.<YOUR_NAME>
```

* See that it times out

* Edit the namespace and add the label `network-policy/web-application: allow`, then deploy the allow-web-application.yaml

```
kubectl edit namespace <YOUR_NAME>-policy
kubectl apply -f allow-web-application.yaml
```

* In your test pod, see that it works again:

```
curl web-application.<YOUR_NAME>
```

* Remove the test setup

```
kubectl delete -f allow-web-application.yaml
kubectl delete -f deny-all.yaml
```

Now go and play a little bit around with [Editor Networkpolicy.io](https://editor.networkpolicy.io) to visually learn how network-policys work in-depth and what kind of options you have!

## Additional Information 

Both Kubernetes NetworkPolicies and CiliumNetworkPolicies are used to control network traffic between pods, but they have key differences in features, flexibility, and enforcement mechanisms. Kubernetes NetworkPolicy is the built-in mechanism for controlling traffic between pods, namespaces, and external sources. These policies use label-based rules to define which pods can communicate with each other. CiliumNetworkPolicy (CNP) extends Kubernetes NetworkPolicies with additional features like L7 filtering, DNS-based rules, and identity-based security. Cilium, which is powered by eBPF, provides enhanced networking and security capabilities.

On most of our on-prem clusters, we use CiliumNetworkPolicies!