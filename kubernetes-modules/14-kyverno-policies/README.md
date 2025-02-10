## **What is Kyverno?**  
Kyverno is a **policy engine for Kubernetes** that allows you to enforce security, compliance, and best practices using **Kubernetes-native policies**. Unlike other policy engines like **OPA/Gatekeeper**, which use Rego, Kyverno uses **YAML-based policies**, making it easier for Kubernetes users to adopt.  

### **Key Features of Kyverno:**  
✅ **Kubernetes-Native** – Policies are managed as Kubernetes resources (no external DSL like Rego).  
✅ **Admission Control & Mutation** – Can **validate, mutate, and generate** Kubernetes resources.  
✅ **Audit & Enforcement** – Can operate in **Audit** mode (logs violations) or **Enforce** mode (blocks violations).  
✅ **Dynamic Configuration** – Can generate configurations dynamically (e.g., default network policies).  
✅ **Policy Aggregation** – Supports **ClusterPolicy** (global) and **Policy** (namespace-scoped).  

---

## **Types of Kyverno Policies**  
Kyverno policies are written as **Custom Resources (CRDs)** in YAML format. There are three main types of policies:  

### **1. Validation Policies** (Deny unwanted configurations)  
👉 **Ensures compliance by blocking or auditing misconfigured resources.**  

🔹 **Example: Ensure all pods have a specific label (`app.kubernetes.io/name`).**  
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-labels
spec:
  validationFailureAction: Enforce  # Can be "Audit" or "Enforce"
  background: true
  rules:
    - name: check-for-labels
      match:
        any:
          - resources:
              kinds:
                - Pod
      validate:
        message: "The label `app.kubernetes.io/name` is required."
        pattern:
          metadata:
            labels:
              app.kubernetes.io/name: "?*"
```

### **2. Mutation Policies** (Modify resources before they are applied)  
👉 **Automatically inject or modify fields in resources.**  

🔹 **Example: Add a default security context to all Pods.**  
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-default-security-context
spec:
  rules:
    - name: add-security-context
      match:
        any:
          - resources:
              kinds:
                - Pod
      mutate:
        patchStrategicMerge:
          spec:
            securityContext:
              runAsNonRoot: true
```

### **3. Generation Policies** (Create new resources automatically)  
👉 **Generates resources when a trigger event occurs (e.g., create a default NetworkPolicy when a Namespace is created).**  

🔹 **Example: Automatically create a NetworkPolicy when a namespace is created.**  
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-default-networkpolicy
spec:
  rules:
    - name: generate-networkpolicy
      match:
        any:
          - resources:
              kinds:
                - Namespace
      generate:
        kind: NetworkPolicy
        name: default-deny
        namespace: "{{request.object.metadata.name}}"
        data:
          spec:
            podSelector: {}
            policyTypes:
              - Ingress
              - Egress
```

---

## **Interacting with Kyverno Policies Using `kubectl`**
Once Kyverno is installed, you can manage policies using `kubectl`.

### **1. Install Kyverno in Kubernetes**

Confirm Kyverno is running:
```sh
kubectl get pods -n kyverno
```

---

### **2. List Kyverno Policies**
#### **List all ClusterPolicies (global policies)**
```sh
kubectl get clusterpolicy
```
#### **List namespace-scoped policies**
```sh
kubectl get policy -n my-namespace
```

---

### **3. View Policy Details**
#### **Describe a ClusterPolicy**
```sh
kubectl describe clusterpolicy require-labels
```
#### **Describe a namespace-scoped Policy**
```sh
kubectl describe policy my-policy -n my-namespace
```

---

### **4. Apply a Policy**
To apply a Kyverno policy:
```sh
kubectl apply -f my-policy.yaml
```

---

### **5. Test a Policy**
To test how a policy applies to a resource **before enforcing it**, use `kyverno apply` (Kyverno CLI).  
```sh
kyverno apply my-policy.yaml --resource my-pod.yaml
```
If Kyverno CLI is not installed, you can simulate a dry-run with `kubectl create`:
```sh
kubectl create -f my-pod.yaml --dry-run=server
```

---

### **6. Delete a Policy**
#### **Delete a ClusterPolicy**
```sh
kubectl delete clusterpolicy require-labels
```
#### **Delete a namespace-scoped Policy**
```sh
kubectl delete policy my-policy -n my-namespace
```

---

### **7. Monitor Kyverno Policy Violations**
To check policy violations:
```sh
kubectl get policyreport -A
```
For more details:
```sh
kubectl describe policyreport -n my-namespace
```

---

## **Conclusion**
Kyverno makes **policy enforcement and automation** easier with its Kubernetes-native approach. By using validation, mutation, and generation policies, you can enforce security best practices, modify resources dynamically, and automate configuration management.  

Would you like a **hands-on example** or a **specific use case**? 🚀