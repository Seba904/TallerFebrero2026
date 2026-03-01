#!/bin/bash

# Instalar las colecciones necesarias

ansible-galaxy collection install -r collections/requirements.yaml

# Ejecutar el playbook maestro

ansible-playbook -i inventories/hosts.ini site.yaml "$@"
