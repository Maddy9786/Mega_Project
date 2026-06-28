
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    yamlencode({ # TF understand HCL language and Helm understand yml so to covnvert HCL to yml 
      server = {
        service = {
          type = "Loadbalancer"
        }
      }

      config = { # Disable HTTS requirement and allow HTTP access to argocd server
        params = {
          "server.instance" = true
        }
      }
      }
    )
  ]

  depends_on = [module.eks]

}