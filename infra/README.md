# Infrastructure for Workshop 


## Cluster Setup 
Everything needed to bootstrap a cluster based on a common DNS name and a raw Kubernetes Cluster 

1. Follow the bootstrap instructions in https://fluxcd.io/flux/installation/bootstrap/github/ and execute "bootstrap.sh" 
2. Check if all applications have successfully bootstrapped 

## Coder and Kubeconfig Setup for Users 

1. Execute `coder login` and create CODER_ADMIN_TOKEN environment variable

Run the workshop-setup script and notate user config
```
infra/02-coder-setup.sh
infra/03-generate-kubeconfigs.sh
```
