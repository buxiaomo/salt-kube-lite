packages:
  pkgs:
    wanted:
      - git
      - less
      - curl
      - openssl
      - conntrack
      - socat
      - ipset
      - wget
      - apt-transport-https
      - software-properties-common
      - unzip
    required:
      pkgs:
        - wget
        - git
        - python3-m2crypto
        - ipvsadm

