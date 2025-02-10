# GitOps with Rancher Fleet 

### What is GitOps?  
GitOps is a modern approach to managing and deploying infrastructure and applications using Git as the single source of truth. It applies DevOps principles using Git repositories to automate deployments, enforce policies, and enable version-controlled changes. Key aspects of GitOps include:  

1. **Declarative Configuration** – The desired state of applications and infrastructure is defined in Git using declarative manifests (e.g., Kubernetes YAML, Helm charts).  
2. **Version Control & Auditing** – Changes are tracked, reviewed, and rollback is possible using Git history.  
3. **Continuous Reconciliation** – A GitOps controller continuously monitors the Git repository and ensures the deployed state matches the declared state.  
4. **Automation & Security** – Automated pipelines (CI/CD) apply changes only when reviewed and merged, improving security and reducing human errors.  

---

### How GitOps Works with Rancher Fleet  
Rancher Fleet is a GitOps-based Kubernetes management tool designed to manage multiple clusters at scale. It integrates GitOps principles with Rancher and Kubernetes, ensuring that cluster configurations and workloads remain consistent across multiple environments.  

#### **How Fleet Works:**  
1. **Git Repository as the Source of Truth**  
   - Fleet watches Git repositories for changes in cluster configurations, Helm charts, or Kubernetes manifests.  
   - These configurations are structured in **Fleet Bundles** (collections of manifests that define applications or cluster policies).  

2. **Fleet Agent Deployment**  
   - A lightweight **Fleet agent** runs in each managed cluster.  
   - The agent continuously reconciles the cluster state with the desired state defined in Git.  

3. **Automatic Sync & Deployment**  
   - When changes are pushed to the repository, Fleet detects them and applies updates across clusters automatically.  
   - It ensures that the live state matches the Git-defined state.  

4. **Multi-Cluster Management**  
   - Fleet can deploy applications and configurations to **single or multiple Kubernetes clusters** simultaneously.  
   - It supports **grouping clusters** based on labels, allowing for flexible deployments (e.g., dev, staging, prod).  

5. **Drift Detection & Rollback**  
   - If a cluster drifts from the Git-defined state (e.g., manual changes or failures), Fleet automatically restores the desired state.  
   - Rollbacks can be performed by reverting changes in Git.  

---

### **Benefits of Using GitOps with Rancher Fleet**
✅ **Scalability** – Manages thousands of clusters efficiently.  
✅ **Security & Compliance** – Enforces policies via Git-based auditing.  
✅ **Automation** – Reduces manual intervention by automating deployments.  
✅ **Consistency** – Ensures all clusters run the same configurations.  
✅ **Observability** – Provides real-time monitoring and drift detection.  

---

## Demo-Exercise 

Since we are all running on the same cluster, the instructors .will be demonstrating how GitOps works with Fleet 

We first create all GitRepo Resources and create a reference to the deployment files in this repository 
```sh
kubectl apply -f kubernetes-modules/12-gitops-fleet/fleet-resources
```

You can watch the deployments in both namespaces 
```sh
kubectl get pods -n fleet-sample-simple
kubectl get pods -n fleet-sample-helm
```

Check out `kubernetes-modules/12-gitops-fleet/helm/fleet.yaml` controls the installation of the Helm chart.