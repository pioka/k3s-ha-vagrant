#!/bin/sh
# Your provisioning script here
set -eu

sed -i 's|/us.archive.ubuntu.com/|/jp.archive.ubuntu.com/|' /etc/apt/sources.list

curl -sfL https://get.k3s.io | sh -s - \
  server \
  --cluster-init \
  --flannel-iface=eth1 \
  --write-kubeconfig-mode=644

mkdir -p /vagrant/local

ip -4 addr show dev eth1 | sed -nE 's|^.*inet ([^/]*).*$|\1|p' > /vagrant/local/primary-node-ip.txt
cat /var/lib/rancher/k3s/server/node-token > /vagrant/local/primary-node-token.txt

sed -E "s/127\.0\.0\.1/$(cat /vagrant/local/primary-node-ip.txt)/" /etc/rancher/k3s/k3s.yaml > /vagrant/local/kubeconfig
