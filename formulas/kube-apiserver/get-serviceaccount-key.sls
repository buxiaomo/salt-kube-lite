{% set sakey_list = salt['mine.get']('roles:ca', 'sa.key', tgt_type='grain').values() %}
{% set sakey_list_split = [] %}
{% for item in sakey_list %}
  {% do sakey_list_split.append(item) %}
{% endfor %}

{% set sacrt_list = salt['mine.get']('roles:ca', 'sa.crt', tgt_type='grain').values() %}
{% set sacrt_list_split = [] %}
{% for item in sacrt_list %}
  {% do sacrt_list_split.append(item) %}
{% endfor %}

{{ pillar['paths']['service_account_key'] }}:
  x509.pem_managed:
    - text: {{ sakey_list_split[0]['/etc/pki/sa.key'] | replace('\n', '') }}
    - user: root
    - group: root
    - mode: 0444

{{ pillar['paths']['service_account_crt'] }}:
  x509.pem_managed:
    - text: {{ sacrt_list_split[0]['/etc/pki/sa.crt'] | replace('\n', '') }}
    - user: root
    - group: root
    - mode: 0444
