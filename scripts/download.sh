#!/bin/bash

# Copyright 2015 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Download the etcd, flannel, and K8s binaries automatically and stored in binaries directory
# Run as root only

# author @resouer @WIZARD-CXY
set -e

ETCD_VERSION=${ETCD_VERSION:-"3.5.0"}
KUBE_VERSION=${KUBE_VERSION:-"1.21.3"}
CNI_PLUGINS_VERSION=${CNI_PLUGINS_VERSION:-"v0.9.1"}
CONTAINERD_VERSION=${CONTAINERD_VERSION:-"1.5.5"}
RUNC_VERSION=${RUNC_VERSION:-"v1.0.1"}
CRITOOLS_VERSION=${CRITOOLS_VERSION:-"1.22.0"}

LOKI_VERSION=${LOKI_VERSION:-"v2.3.0"}
PROMTAIL_VERSION=${PROMTAIL_VERSION:-"v2.3.0"}

function cleanup {
  # cleanup work
  rm -rf kube* etcd* binaries
}
trap cleanup SIGHUP SIGINT SIGTERM

pushd $(dirname $0)
mkdir -p binaries

# ectd
ETCD="etcd-v${ETCD_VERSION}-linux-amd64"
echo "Prepare etcd ${ETCD_VERSION} release ..."
grep -q "^${ETCD_VERSION}\$" binaries/.etcd 2>/dev/null || {
  curl -L https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/${ETCD}.tar.gz -o binaries/${ETCD}.tar.gz
  echo ${ETCD_VERSION} > binaries/.etcd
}

# k8s
echo "Prepare kubernetes ${KUBE_VERSION} release ..."
grep -q "^${KUBE_VERSION}\$" binaries/.kubernetes 2>/dev/null || {
 curl -L "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-apiserver" -o binaries/kube-apiserver
 curl -L "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-controller-manager" -o binaries/kube-controller-manager
 curl -L "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-scheduler" -o binaries/kube-scheduler
 curl -L "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" -o binaries/kubectl
 curl -L "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-proxy" -o binaries/kube-proxy
 curl -L "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubelet" -o binaries/kubelet
 echo ${KUBE_VERSION} > binaries/.kubernetes
}

# cni-plugins
CNI_PLUGINS="cni-plugins-linux-amd64-${CNI_PLUGINS_VERSION}"
echo "Prepare CNI_PLUGINS ${CNI_PLUGINS_VERSION} release ..."
grep -q "^${CNI_PLUGINS_VERSION}\$" binaries/.CNI_PLUGINS 2>/dev/null || {
  curl -L https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VERSION}/${CNI_PLUGINS}.tgz -o binaries/${CNI_PLUGINS}.tgz
  echo ${CNI_PLUGINS_VERSION} > binaries/.cni-plugins
}

#containerd
CONTAINERD="containerd-${CONTAINERD_VERSION}-linux-amd64"
echo "Prepare CONTAINERD ${CONTAINERD_VERSION} release ..."
grep -q "^${CONTAINERD_VERSION}\$" binaries/.containerd 2>/dev/null || {
  curl -L https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/${CONTAINERD}.tar.gz -o binaries/${CONTAINERD}.tar.gz
  echo ${CONTAINERD_VERSION} > binaries/.containerd
}

#runc
echo "Prepare runc ${RUNC_VERSION} release ..."
grep -q "^${RUNC_VERSION}\$" binaries/.runc 2>/dev/null || {
  curl -L https://github.com/opencontainers/runc/releases/download/${RUNC_VERSION}/runc.amd64 -o binaries/runc.amd64
  echo ${RUNC_VERSION} > binaries/.runc
}


#cri-tools
CRITOOLS="crictl-v${CRITOOLS_VERSION}-linux-amd64"
echo "Prepare CRITOOLS ${CRITOOLS_VERSION} release ..."
grep -q "^${CRITOOLS_VERSION}\$" binaries/.critools 2>/dev/null || {
  curl -L https://github.com/kubernetes-sigs/cri-tools/releases/download/v${CRITOOLS_VERSION}/${CRITOOLS}.tar.gz -o binaries/${CRITOOLS}.tar.gz
  echo ${CRITOOLS_VERSION} > binaries/.critools
}

#loki
LOKI="loki-linux-amd64.zip"
echo "Prepare LOKI ${LOKI_VERSION} release ..."
grep -q "^${LOKI_VERSION}\$" binaries/.loki 2>/dev/null || {
  curl -L https://github.com/grafana/loki/releases/download/${LOKI_VERSION}/${LOKI} -o binaries/${LOKI}
  echo ${LOKI_VERSION} > binaries/.loki
}

#promtail
PROMTAIL="promtail-linux-amd64.zip"
echo "Prepare PROMTAIL ${PROMTAIL_VERSION} release ..."
grep -q "^${PROMTAIL_VERSION}\$" binaries/.promtail 2>/dev/null || {
  curl -L https://github.com/grafana/loki/releases/download/${PROMTAIL_VERSION}/${PROMTAIL} -o binaries/${PROMTAIL}
  echo ${PROMTAIL_VERSION} > binaries/.promtail
}

echo "Done! All your binaries locate in tests/binaries directory"
popd
