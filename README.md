# Lab with EKS
## Get kubeconfig
https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
https://docs.aws.amazon.com/cli/latest/reference/eks/update-kubeconfig.html

  brew update
  brew install kubectl terraform kustomize fluxcd/tap/flux
  brew upgrade kubectl terraform kustomize fluxcd/tap/flux

  awscredentials

  terraform apply terraform/

  aws eks --profile 910881736194_Administrator --region eu-west-1 update-kubeconfig --name eks-cluster --alias eks 
  kubectl config use-context eks

  flux check --pre

  eval $(op signin) &&\
  export GITHUB_TOKEN=$(op get item "Github - fluxcd" --fields credential) &&\
  export GITHUB_USER=$(op get item "Github - fluxcd" --fields username)



  #  flux install \
  #  --version=latest \
  #  --namespace=flux-system

  


  flux bootstrap github \
  --repository=fleet-infra \
  --owner=${GITHUB_USER} \
  --branch=main \
  --path=./clusters/eks-cluster \
  --personal \
  --private


