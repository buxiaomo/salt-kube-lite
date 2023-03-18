---
promtail_group_user:
  group.present:
    - name: promtail
    - system: True
  user.present:
    - name: promtail
    - createhome: False
    - groups:
      - systemd-journal
      - adm
      - promtail
    - require:
      - group: promtail

/opt/promtail:
  file.directory:
    - mode: 0755
    - makedirs: True
    - user: promtail
    - group: promtail

unzip_promtail_package:
  archive.extracted:
    - name: /tmp/promtail
    - source: salt://promtail/files/promtail-linux-amd64.zip
    - use_cmd_unzip: True
    - enforce_toplevel: False
    - unless: test -f /usr/local/bin/promtail

promtail_install:
  file.rename:
    - name: /usr/local/bin/promtail
    - source: /tmp/promtail/promtail-linux-amd64
    - makedirs: True
    - watch:
      - archive: unzip_promtail_package
    - require:
      - archive: unzip_promtail_package

