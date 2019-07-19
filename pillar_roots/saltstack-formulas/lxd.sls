lxd:
  containers:
    local:
      bootstraptest:
        opts:
          require:
          - {lxd_profile: lxd_profile_local_default}
          - {lxd_profile: lxd_profile_local_autostart}
          - {lxd_profile: lxd_profile_local_small}
          - {lxd_image: lxd_image_local_ubuntu_xenial_amd64}
        profiles: [default, autostart, small]
        running: true
        source: xenial/amd64
        bootstrap_scripts:
          - cmd: [ '/bin/sleep', '2' ]

          - src: salt://lxd/scripts/bootstrap.sh
            dst: /root/bootstrap.sh
            cmd: [ '/root/bootstrap.sh', 'bootstraptest', 'pcdummy.lan', 'salt.pcdummy.lan', 'true' ]

          - cmd: [ '/usr/bin/salt-call', 'state.apply' ]
      ubuntu-trusty:
        running: True
        source: trusty/amd64
        profiles:
          - default
          - autostart
          - shared_mount
        config:
          boot.autostart.priority: 1000
        opts:
          require:
            - {lxd_profile: lxd_profile_local_autostart}
            # {lxd_profile: lxd_profile_local_shared_mount}
            - {lxd_image: lxd_image_local_ubuntu_trusty_amd64}
      alpine-34:
        running: True
        source: alpine/3.4/amd64
        profiles:
          - default
          - autostart
          - small
        config:
          boot.autostart.priority: 1000
        opts:
          require:
            - {lxd_profile: lxd_profile_local_autostart}
            - {lxd_profile: lxd_profile_local_small}
            - {lxd_image: lxd_image_local_alpine_3_4_amd64}

  images:
    local:
      ubuntu_xenial_amd64:
        name: ubuntu/xenial/amd64 
        aliases:
          - xenial/amd64
        auto_update: true
        public: false
        source:
          name: ubuntu/xenial/amd64
          remote: images_linuxcontainers_org
      ubuntu_trusty_amd64:
        name: ubuntu/trusty/amd64
        aliases:
          - trusty/amd64
        auto_update: True
        public: False
        source:
          name: ubuntu/trusty/amd64
          remote: images_linuxcontainers_org
      alpine_3_4_amd64:
        name: alpine/amd64
        aliases:
          - alpine/3.4/amd64
        auto_update: true
        public: false
        source:
          name: alpine/3.4/amd64
          remote: images_linuxcontainers_org

  lxd:
    run_init: true
    init: {network_address: '[::]', network_port: 8443, trust_password: PassW0rd}
    config:
      password:
        key: core.trust_password 
        value: "PaSsW0rD"
        force_password: True    # Currently this is executed every time

  profiles:
    local:
      autostart:
        config:
          boot.autostart: 1
          boot.autostart.delay: 2
          boot.autostart.priority: 1
      default:
        devices:
          eth2:
            nictype: bridged
            parent: lxdbr0
            type: nic
      shared_mount:
        devices:
          shared_mount:
            type: "disk"
            # Source on the host
            source: "/home/shared"
            # Path in the container
            path: "home/shared"
      small:
        config:
          limits.cpu: 1
          limits.memory: 512MB
        device:
          root:
            limits.read: 20Iops
            limits.write: 10Iops

  python: {use_pip: False}
  #remotes:
  #  local: {cert: /root/.config/lxc/client.crt, key: /root/.config/lxc/client.key,
  #    password: PassW0rd, remote_addr: 'https://localhost:8443', type: lxd, verify_cert: false}
