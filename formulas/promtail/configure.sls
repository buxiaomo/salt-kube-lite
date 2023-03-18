---

configure-promtail-service:
  file.managed:
    - name: /etc/systemd/system/promtail.service
    - source: salt://promtail/files/service.promtail.jinjia
    - template: jinja
  module.run:
    - name: service.systemctl_restart
    - onchanges:
      - file: configure-promtail-service

configure-promtail:
  file.managed:
    - name: /opt/promtail/config-promtail.yml
    - source: salt://promtail/files/config-promtail.yml.jinja
    - template: jinja
    - makedirs: True
    - user: promtail
    - group: promtail
  module.run:
    - name: service.systemctl_restart
    - onchanges:
      - file: configure-promtail-service

promtail_running:
  service.running:
    - name: promtail
    - enable: True
    - watch:
      - file: configure-promtail-service
      - file: configure-promtail
    - require:
      - file: configure-promtail-service
      - file: configure-promtail