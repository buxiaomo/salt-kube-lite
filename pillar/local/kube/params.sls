kubernetes:
  lookup:
    version: v1.21.3
    local_install: True
    package_url: "https://storage.googleapis.com/kubernetes-release/release"
    kube-apiserver:
      hash: f8fc46f1acfef88f094bbd6e648d2a00e49687260d5d71fec00bbf96590eb987
      services_cidr: '10.24.0.0/16'
      cluster_ip: '10.24.0.1'
      encryption_key: q7wCru4rcMib0pQl5RX6QavKFZNMGNTfk6jNZwWC5es=
      apiserver_port: '6443'
      PUBLIC_ADDRESS: '172.16.10.10'
      external_fqdn: ''
    kube-controller-manager:
      hash: 6b813b52e240bc61acafe70434d334c5a21732093552af9be6aaba5bb060b63b
      cluster_cidr: '10.200.0.0/16'
    kube-proxy:
      hash: 7283dfb06c13590cc34c524ca902b9a0d748394bb27e8b6d7b967d0a31556a80
    kube-scheduler:
      hash: 9e75952e5df826ec2e43314bd83cf39f9728e80ea0680a39cb8cc4c5c940e903
    kubelet:
      hash: 5bd542d656caabd75e59757a3adbae3e13d63c7c7c113d2a72475574c3c640fe
      port: '10250'
      # infra container to use instead of downloading gcr.io/google_containers/pause
      # pod_infra_container_image: 172.21.3.76:5000/k8s/pause-amd64:3.1
      compute-resources:
        kube:
          cpu: ''
          memory: ''
          ephemeral-storage: ''
          # example:
          # cpu: 100m
          # memory: 100M
          # ephemeral-storage: 1G
        system:
          cpu: ''
          memory: ''
          ephemeral-storage: ''
      eviction-hard: ''
      # example:
      # eviction-hard: memory.available<500M
      # Drain timeout, in seconds
      drain-timeout: '600'
      # DNS service IP and some other stuff (must be inside the 'services_cidr')
      dns:
        cluster_ip:     '10.24.0.2'
        domain:         'cluster.local'
        replicas:       '3'
    # kubernetes feature gates to be enabled
    # https://kubernetes.io/docs/reference/feature-gates/
    # params passed to the --feature-gates cli flag.
    feature_gates: ''
    #runtime configurations that may be passed to apiserver.
    # can be used to turn on/off specific api versions.
    # api/all is special key to control all api versions
    runtime_configs:
      - admissionregistration.k8s.io/v1alpha1
      - batch/v2alpha1
    admission_control:
      # - 'Initializers'
      - 'NamespaceLifecycle'
      - 'LimitRanger'
      - 'ServiceAccount'
      - 'NodeRestriction'
      - 'PersistentVolumeLabel'
      - 'DefaultStorageClass'
      - 'ResourceQuota'
      - 'DefaultTolerationSeconds'


paths:
  service_account_key: '/etc/pki/sa.key'
  service_account_crt: '/etc/pki/sa.crt'
  var_kubelet:    '/var/lib/kubelet'
  kubeconfig:     '/var/lib/kubernetes/kubeconfig'
  kube_scheduler_config: '/var/lib/kubernetes/kube-scheduler.kubeconfig'
  kube_controller_manager_config: '/var/lib/kubernetes/kube-controller-manager.kubeconfig'
  kubelet_config: '/var/lib/kubernetes/kubelet-config'
  kube_proxy_config: '/var/lib/kubernetes/kube-proxy-config'

# set log level for kubernetes services
# 0 - Generally useful for this to ALWAYS be visible to an operator.
# 1 - A reasonable default log level if you don't want verbosity.
# 2 - Useful steady state information about the service and important log
#     messages that may correlate to significant changes in the system.
#     This is the recommended default log level for most systems.
# 3 - Extended information about changes.
# 4 - Debug level verbosity.
# 6 - Display requested resources.
# 7 - Display HTTP request headers.
# 8 - Display HTTP request contents.
kube_log_level:   '2'

# CNI network configuration
cni:
  plugin: 'cilium'
  cilium_version: 'v1.9.5'
  cni_plugins_version: 'v0.9.1'
  cni_plugins_hash: '962100bbc4baeaaa5748cdbfce941f756b1531c2eadb290129401498bfac21e7'


