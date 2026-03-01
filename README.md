# Taller Servidores Linux - Obligatorio Febrero 2026

Este proyecto implementa una infraestructura mínima automatizada con Ansible:

▪️ Servidor NFS en CentOS.

▪️ Cliente Ubuntu con autofs.

▪️ Servicio systemd. 

## Topologia

  | Hostname | Sistema Operativo |         Rol          |      IP       |
  |:---------|:-----------------:|:--------------------:|--------------:|
  |  nfs01   |  CentOs Stream 9  |     Servidor NFS     | 192.168.10.11 |
  |  app01   |    Ubuntu 24.04   | Cliente Autofs + Web | 192.168.10.21 |

## Requisitos Previos

▪️ Servidores limpios con acceso a SSH.

▪️ Ansible instalado.

## Ejecucion de comandos

Para instalar las colecciones necesarias para el funcionamiento de los playbooks:

	ansible-galaxy collection install -r collections/requirements.yaml

Los playbooks son idempotentes.

Para ejecutar el playbook maestro:

	ansible-playbook -i inventories/hosts.ini site.yaml --ask-become-pass

Para ejecutrar ambos comandos a la vez:

	./run.sh

## Resulatdos esperados

Para verificar que la infraestrucutra esta bien configurada:

### En nfs01

	systemctl is-active nfs-server
	# Esperado: active
	
	exportfs -v
	# Esperado: muestra /srv/nfs/shared exportado a la red 192.168.10.0/24 con permisos RW
	
	firewall-cmd --list-services | egrep 'nfs|mountd|rpc-bind'
	# Esperado: aparecen habilitados los servicios nfs, mountd y rpc-bind
	
	ls -l /srv/nfs/shared/README-NFS.txt
	# Esperado: archivo presente en el directorio compartido

### En app01

	systemctl is-active autofs
	# Esperado: active

	mount | grep /mnt/shared
	# Esperado: nada antes de acceder

	ls /mnt/shared
	# Esperado: contenido del NFS, fuerza el automount

	mount | grep /mnt/shared
	# Esperado: ahora muestra el recurso NFS montado

### Servicio HTTP systemd

	systemctl status shared-http --no-pager
	# Esperado: servicio habilitado y activo

	curl -I http://localhost:8080/
	# Esperado: HTTP/1.0 200 OK (o 301/302 aceptable)

	curl http://localhost:8080/README-NFS.txt
	# Esperado: devuelve el contenido del archivo README-NFS.txt

	journalctl -u shared-http -n 50 --no-pager
	# Esperado: logs recientes del servicio sin errores
