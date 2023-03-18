{% set package_url = salt.caasp_pillar.get('kubernetes:lookup:package_url') %}
{% set version = salt.caasp_pillar.get('kubernetes:lookup:version') %}
{% set hash = salt.caasp_pillar.get('kubernetes:lookup:kubelet:hash') %}
{% set local_install = salt.caasp_pillar.get('kubernetes:lookup:local_install') %}

kubelet-package-download:
  file.managed:
    - name: /usr/local/bin/kubelet
{%- if local_install %}
    - source: salt://kubelet/files/kubelet
{% else %}
    - source: {{ package_url }}/{{ version }}/bin/linux/amd64/kubelet
{% endif %}
    - source_hash: sha256={{ hash }}
    - mode: 711
    - unless: test -f /usr/local/bin/kubelet

configure-kubelet-service:
  file.managed:
    - name: /etc/systemd/system/kubelet.service
    - source: salt://kubelet/files/service.kubelet.conf.jinja
    - template: jinja
  module.run:
    - name: service.systemctl_restart
    - onchanges:
      - file: configure-kubelet-service
