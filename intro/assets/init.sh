#!/bin/bash

# init scenario
rm $0
bash /ks/k8s.sh
mkdir -p /opt/ks
cat <<EOT > /root/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
EOT


# scenario specific
kubectl -f /ks/init.yaml create

TRIVY_VERSION=0.22.0
wget https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.deb
dpkg -i trivy_${TRIVY_VERSION}_Linux-64bit.deb


# mark init finished
touch /ks/.initfinished
