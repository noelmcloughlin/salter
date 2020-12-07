# -*- coding: utf-8 -*-
# vim: ft=yaml
---
airflow:
  Ref: https://github.com/saltstack-formulas/airflow-formula/blob/master/pillar.example
  security:
    airflow:
      user: airflow
      pass: airflow
      email: airflow@localhost
  config:
    airflow:
      content:
        authentication: True
        executor: LocalExecutor
      state_colors:
        # https://airflow.apache.org/docs/apache-airflow/stable/howto/customize-state-colors-ui.html
        queued: 'darkgray'
        running: '#01FF70'
        success: '#2ECC40'
        failed: 'firebrick'
        up_for_retry: 'yellow'
        up_for_reschedule: 'turquoise'
        upstream_failed: 'orange'
        skipped: 'darkorchid'
        scheduled: 'tan'
  service:
    airflow:
      enabled:
        - airflow-flower
        - airflow-scheduler
        - airflow-webserver
        - airflow-worker
  pkg:
    airflow:
      version: 1.10.13
      use_upstream: pip
      extras:
        # Ref: https://airflow.apache.org/docs/apache-airflow/stable/installation.html#extra-packages
        - password       # Password authentication for users
        - jira                 # Jira hooks and operators
        - async                # Async worker classes for Gunicorn
        - celery               # CeleryExecutor
        - kubernetes           # Kubernetes Executor and operator
        - redis                # Redis hooks and sensors
        - ssh                  # SSH hooks and Operator
        - winrm                # WinRM hooks and operators

  dir:
    airflow:
      config: /home/airflow/airflow
  linux:
    altpriority: {{ range(1, 9100000) | random }}   # zero disables alternatives
