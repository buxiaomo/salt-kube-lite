---
loki_group_user:
  group.present:
    - name: loki
    - system: True
  user.present:
    - name: loki
    - createhome: False
    - groups:
      - loki
    - require:
      - group: loki

/opt/loki:
  file.directory:
    - mode: 0755
    - makedirs: True
    - user: loki
    - group: loki

loki_data_path:
  file.directory:
    - name: /data/loki
    - makedirs: True
    - dir_mode: 700
    - file_mode: 700
    - user: loki
    - group: loki
    - require:
      - group: loki
      - user: loki

unzip_loki_package:
  archive.extracted:
    - name: /tmp/loki
    - source: salt://loki/files/loki-linux-amd64.zip
    - use_cmd_unzip: True
    - enforce_toplevel: False
    - unless: test -f /usr/local/bin/loki

loki_install:
  file.rename:
    - name: /usr/local/bin/loki
    - source: /tmp/loki/loki-linux-amd64
    - makedirs: True
    - watch:
      - archive: unzip_loki_package
    - require:
      - archive: unzip_loki_package

