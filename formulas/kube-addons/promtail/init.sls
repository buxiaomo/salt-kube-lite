include:
  - kube-config

{% if 'kube-master' in salt['grains.get']('roles', []) %}
{% if salt.caasp_pillar.get('addons:promtail', True) %}

{% from '_macros/kubectl.jinja' import kubectl, kubectl_apply_dir_template with context %}


{{ kubectl_apply_dir_template("salt://kube-addons/promtail/manifests/",
                              "/etc/kubernetes/addons/promtail/") }}

{% else %}

promatil-dummy:
  cmd.run:
    - name: echo "PROMTAIL addon not enabled in config"

{% endif %}
{% endif %}
