# EKS boilerplate

This boilerplate contains an EKS cluster purely integrated with AWS

- AWS SSO RBAC authentication

## TODO

- [ ] Cluster autoscaler: 
  - https://eksctl.io/usage/autoscaling/
  - https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html
  - https://www.eksworkshop.com/beginner/080_scaling/deploy_ca/

- [ ] KMS to encrypt etcd

- [ ] Secret manager: https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html

- [ ] AWS AppMesh, mTLS

- [ ] Go scripts to render cluster configurations and roles 