local:
  'os:Ubuntu':
      - match: grain
      - common.packages_ubuntu
  'os:(RedHat|CentOS)':
      - match: grain_pcre
      - common.packages_centos
  '*':
    - common
    - salt.salt
    - salt.minion
    - salt.mine
    - salt.beacons
    - salt.schedule
  'roles:salt':
    - match: grain
    - salt.master
  'roles:ca':
    - match: grain
    - kube.ca
  'roles:(salt|kube-master|kube-minion|etcd)':
    - match: grain_pcre
    - kube.ca-cert
    - kube.params
  'roles:kube-minion':
    - match: grain
    - containerd
  'roles:etcd':
    - match: grain
    - etcd
  'roles:monitoring':
    - match: grain
    - grafana
  'roles:kube-master':
    - match: grain
    - promtail.logtype
