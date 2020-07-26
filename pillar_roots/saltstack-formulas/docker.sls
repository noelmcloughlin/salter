docker-containers:
  lookup:

    # example docker registry container (if you want your own docker registry, use this)
    registry:
       {%- if grains.os == 'Fedora' %}
      image: 'docker.io/registry:latest'
       {%- else %}
      image: "registry:latest"
       {%- endif %}
      cmd:
      # Pull image on service restart (useful if you override the same tag. example: latest)
      pull_before_start: True
      runoptions:
        - "-e REGISTRY_LOG_LEVEL=warn"
        - "-e REGISTRY_STORAGE=s3"
        - "-e REGISTRY_STORAGE_S3_REGION=us-west-1"
        - "-e REGISTRY_STORAGE_S3_BUCKET=my-bucket"
        - "-e REGISTRY_STORAGE_S3_ROOTDIRECTORY=/registry"
        - "--log-driver=syslog"
        - "-p 5000:5000"
        - "--rm"

    javapp:
      image: tomcat:latest
      cmd:
      runoptions:
        - "-v /home/undefined_user/javapp:/javapp"
        - "-p 8888:8080"
        - "-it --rm"
      stopoptions:
        - -t 60

# Docker
docker-pkg:
  lookup:
    process_signature: /usr/bin/docker

    # config for sysvinit/upstart (for systemd, use drop-ins in your own states)
    config:
      - DOCKER_OPTS="-s btrfs --dns 8.8.8.8"
      - export http_proxy="http://10.20.30.40:3128"

# Docker
docker:
  # version of docker-compose to install (defaults to latest)
  #compose_version: 1.9.0

  pkg:
        {%- if grains.os == 'MacOS' %}
    use_upstream_app: true   a #docker desktop for mac
        {%- else %}
    use_upstream_app: false
        {%- endif %}
    app:
      source: https://download.docker.com/mac/stable/Docker.dmg
      source_hash: f69bd8f9d0863497819b998d27da4825b65884519f3f6a0e2ce1d4c5cdd26f5e

  # Global functions for docker_container.running states
  containers:
    skip_translate: ports
    force_present: False
    force_running: True

  # Docker Compose
  compose:
    registry-datastore:
      dvc: True
       {%- if grains.os == 'Fedora' %}
      image: &registry_image 'docker.io/registry:latest'
       {%- else %}
      image: &registry_image 'registry:latest'
       {%- endif %}
      container_name: &dvc 'registry-datastore'
      command: echo *dvc data volume container
      volumes:
        - &datapath '/registry'
    registry-service:
      image: *registry_image
      container_name: 'registry-service'
      volumes_from:
        - *dvc
      environment:
        SETTINGS_FLAVOR: 'local'
        STORAGE_PATH: *datapath
        SEARCH_BACKEND: 'sqlalchemy'
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY: '/registry'
      ports:
        - 127.0.0.1:5000:5000
      #restart: 'always'    # compose v1.9
      deploy:               # compose v3
        restart_policy:
          condition: on-failure
          delay: 5s
          max_attempts: 3
          window: 120s
    nginx-latest:
       {%- if grains.os == 'Fedora' %}
      image: 'docker.io/nginx:latest'
       {%- else %}
      image: 'nginx:latest'
       {%- endif %}
      container_name: 'nginx-latest'
      links:
        - 'registry-service:registry'
      ports:
        - '80:80'
        - '443:443'
      volumes:
        - /srv/docker-registry/nginx/:/etc/nginx/conf.d
        - /srv/docker-registry/auth/:/etc/nginx/conf.d/auth
        - /srv/docker-registry/certs/:/etc/nginx/conf.d/certs
      #restart: 'always'    # compose v2
      deploy:               # compose v3
        restart_policy:
          condition: on-failure
          delay: 5s
          max_attempts: 3
          window: 120s
