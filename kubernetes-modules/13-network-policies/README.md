# network-policies

* Deny all traffic to web-application

```
kubectl apply -f deny-all.yaml
```

* Start a busybox container pod in another namespace **in a different shell**

```
kubectl apply -f connecting-pod.yaml
 kubectl exec -it pods/network-policy-test -- sh

# In the pod: Try to reach your web-application
curl web-application-int:80 -v
```

* See that it times out

* Check out our new NetworkPolicy that allows the connectin-test pod to connect to our backend application!

```
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