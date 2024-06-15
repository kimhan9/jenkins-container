# Jenkins Deploy to Kubernetes

This repo along with https://github.com/kimhan9/kubernetesmanifest creates a Jenkins pipeline with GitOps to deploy code into a Kubernetes cluster. CI part is done via Jenkins and CD part via ArgoCD (GitOps).

# Install ArgoCD

Install ArgoCD in your Kubernetes cluster following this link - https://argo-cd.readthedocs.io/en/stable/getting_started/


## Steps

- Create new namespace, services and application resources.
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

- Port forwarding
```
kubectl port-forward svc/argocd-server -n argocd 8081:443 &
```

- Retrieve initial password
```
argocd admin initial-password -n argocd
```

## Creating App via CLI

- Set current namespace to argocd
```
kubectl config set-context --current --namespace=argocd
```

- Create the example application
```
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
```

## Creating App via ArgoCD UI

- *GENERAL*
  - Application Name: `<App Name>`
  - Project Nane: `Default`
  - Sync Policy: `Automatic`
- *SOURCE*
  - Repositority URL: `https://github.com/kimhan9/kubernetesmanifest.git`
  - Revision: `HEAD`
  - Path: `./`