salt:
  master:
    log_level: info
    open_mode: True
    state_output: mixed
    presence_events: True
    worker_threads: 20
    zmq_backlog: 2000
    timeout: 20
    auto_accept: True
    peer:
      .*:
        - x509.sign_remote_certificate
      stage:
        - state.apply
        - state.sls
    peer_run:
      .*:
        - x509.sign_remote_certificate
    file_roots:
      local:
        - /srv/salt/local
        - /srv/salt/local/roles
        - /srv/formulas
    pillar_roots:
      local:
        - /srv/pillar/local
    verify_env: True
    reactor:
      - 'salt/presence/change':
        - /srv/reactor/presence.sls
        - /srv/reactor/etc-hosts.sls
      - 'salt/beacon/*/network_settings/*':
        - /srv/reactor/etc-hosts.sls
      - 'salt/minion/*/start':
        - /srv/reactor/etc-hosts.sls
        - /srv/reactor/sync-modules.sls
        - /srv/reactor/update-mine.sls