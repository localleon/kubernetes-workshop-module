# Ingress and TLS

Traefik routes an HTTPS hostname to the Service. cert-manager issues the certificate. Ask your instructor for a hostname that points to the lab, then replace the example hostname below.

```sh
kubectl apply -f ../03-services/deployment-web.yaml -f ../03-services/service-clusterip.yaml
kubectl rollout status deployment/web-application --timeout=120s

host=workshop.example.test
sed "s/workshop[.]example[.]test/$host/g" web-application/deployment/ingress.yaml | kubectl apply -f -
kubectl get ingress web-application
kubectl wait --for=create certificate/web-application-tls --timeout=60s
kubectl wait --for=condition=Ready certificate/web-application-tls --timeout=180s
curl --fail --show-error "https://$host/"
```

If the certificate stays pending, check the hostname and ask the instructor to verify DNS and the issuer.

```sh
kubectl delete ingress web-application
kubectl delete -f ../03-services/service-clusterip.yaml -f ../03-services/deployment-web.yaml
```
