/tmp/debug:
  file.managed:
    - source: salt://debug/tmp.jinja
    - template: jinja
    - makedirs: True