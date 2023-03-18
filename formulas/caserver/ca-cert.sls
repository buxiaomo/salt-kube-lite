include:
  - cert.require

{{ pillar['ssl']['ca_dir'] }}:
  file.directory:
    - makedirs: True
    - user: root
    - group: root
    - mode: 755

{% set cacrt_list = salt['mine.get']('roles:ca', 'ca.crt', tgt_type='grain').values() %}
{% set cacrt_list_split = [] %}
{% for item in cacrt_list %}
  {% do cacrt_list_split.append(item) %}
{% endfor %}

{{ pillar['ssl']['ca_file'] }}:
  x509.pem_managed:
    - text: {{ cacrt_list_split[0]['/etc/pki/ca.crt']|replace('\n', '') }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: {{ pillar['ssl']['ca_dir'] }}

{% if 'kube-master' in salt['grains.get']('roles', []) %}
{% set cakey_list = salt['mine.get']('roles:ca', 'ca.key', tgt_type='grain').values() %}
{% set cakey_list_split = [] %}
{% for item in cakey_list %}
  {% do cakey_list_split.append(item) %}
{% endfor %}

ensure get {{ pillar['ssl']['ca_file_key'] }}:
  x509.pem_managed:
    - name: {{ pillar['ssl']['ca_file_key'] }}
    - text: {{ cakey_list_split[0]['/etc/pki/ca.key']|replace('\n', '') }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: {{ pillar['ssl']['ca_dir'] }}
{% endif %}