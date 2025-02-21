# Update FluxCD manifests with current infrastructure setup! 
userAssignedIdentityID=$(az identity list --query "[?name=='aks-dev0-external-dns-identity'].id" -o tsv)       
sed -i "s|\(azure.workload.identity/client-id:\s*\).*|\1$userAssignedIdentityID|" infra/fluxcd-apps/external-dns.yaml

# Commit and push changes to the repository
git add infra/fluxcd-apps/external-dns.yaml
git commit -m "Update external-dns identity"
git push

# Bootstrap FluxCD 
flux bootstrap github \
  --token-auth \
  --owner=localleon \
  --repository=kubernetes-workshop-module \
  --branch=main \
  --path=infra/fluxcd \
  --personal

