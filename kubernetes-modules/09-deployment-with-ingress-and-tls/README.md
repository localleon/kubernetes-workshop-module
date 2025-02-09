# Deployment with Ingress and TLS

* Take a look at the ingress documentation (https://kubernetes.io/docs/concepts/services-networking/ingress/)
* Make sure you still have all resources from 03-services still running! 
* Edit hostnames in `web-application/deployment/ingress.yaml`
* Deploy application

```sh
# with nginx
kubectl apply -f web-application/deployment/ingress.yaml
```

You can watch the DNS record get created with the ExternalDNS Operator. [ExternalDNS Operator](https://github.com/kubernetes-sigs/external-dns) is a sub-project of the Kubernetes project to dynamically create domains for your ingress records. On our private cloud, we still need to publish these records manually.

```sh
kubectl logs -n external-dns deployments/external-dns
```

