#!/bin/sh
# Your provisioning script here
set -eu

sed -i 's|/us.archive.ubuntu.com/|/jp.archive.ubuntu.com/|' /etc/apt/sources.list

curl -sfL https://get.k3s.io | sh -s - \
  server \
  --server=https://$(cat /vagrant/local/primary-node-ip.txt):6443 \
  --token=$(cat /vagrant/local/primary-node-token.txt) \
  --flannel-iface=eth1 \
  --write-kubeconfig-mode=644
