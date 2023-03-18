---
base:
  pkgrepo.managed:
    - humanname: grafana-oss-stage
    - name: deb https://packages.grafana.com/oss/deb stable main
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: https://packages.grafana.com/gpg.key

grafana:
  pkg.installed:
    - version: {{ pillar['grafana']['version'] }}
    - refresh: True
    - skip_verify: True
