include:
  - cert.require

{% if not salt['file.directory_exists']('/etc/pki/sa.key') and not salt['file.directory_exists']('/etc/pki/sa.crt') %}
create_sakey:
  x509.private_key_managed:
    - name: /etc/pki/sa.key
    - bits: 4096
    - backup: True
    - require:
      - file: /etc/pki
      - sls: cert.require

create_sacrt:
  x509.certificate_managed:
    - name: /etc/pki/sa.crt
    - signing_private_key: /etc/pki/sa.key
    - days_valid: 3650
    - days_remaining: 0
    - backup: True
    - require:
      - file: /etc/pki
      - x509: /etc/pki/sa.key
{% endif %}