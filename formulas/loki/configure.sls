---

configure-loki-service:
  file.managed:
    - name: /etc/systemd/system/loki.service
    - source: salt://loki/files/service.loki.jinjia
    - template: jinja
  module.run:
    - name: service.systemctl_restart
    - onchanges:
      - file: configure-loki-service

configure-loki:
  file.managed:
    - name: /opt/loki/config-loki.yml
    - source: salt://loki/files/config-loki.yml.jinja
    - template: jinja
    - makedirs: True
  module.run:
    - name: service.systemctl_restart
    - onchanges:
      - file: configure-loki-service

loki_running:
  service.running:
    - name: loki
    - enable: True
    - reload: True
    - watch:
      - file: configure-loki-service
    - require:
      - file: configure-loki-service