helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system --set tokenRequests\[0\].audience=pods.eks.amazonaws.com

helm install secrets-provider-aws aws-secrets-manager/secrets-store-csi-driver-provider-aws --namespace kube-system --set secrets-store-csi-driver.install=false

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=gp-eks-cluster --set region=ap-south-1 \
  --set vpcId=vpc-06cbaa0df261db516 \
  --set serviceAccount.create=true \
  --set serviceAccount.name=aws-load-balancer-controller 

kubectl run mysql-client --rm -it --image=mysql:8.0 --restart=Never -- mysql -h catalog-rds-instance.cz66w0ygo6po.ap-south-1.rds.amazonaws.com -u catalog -p

kubectl port-forward svc/catalog-svc 7080:8080