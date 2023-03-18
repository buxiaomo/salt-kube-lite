---

config-grafana:
  file.managed:
    - name: /etc/grafana/grafana.ini
    - source: salt://grafana/files/grafana.ini.jinjia
    - template: jinja

start-grafana:
  service.running:
    - name: grafana-server
    - enable: true
    - reload: true
    - watch:
      - file: config-grafana