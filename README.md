# Taller Servidores Linux - Obligatorio Febrero 2026

Este proyecto implementa una infraestructura mínima automatizada con Ansible:

▪️ Servidor NFS CentOS Stream 9.

▪️ Cliente Ubuntu 

## Topologia

  | Hostname |        Rol           |       IP      |
  |----------|:--------------------:|---------------|
  |  nfs01   | Servidor NFS         | 192.168.10.11 |
  |  app01   | Cliente Autofs + Web | 192.168.10.21 |

## Requisitos Previos

▪️ Servidores limpios con acceso a SSH
▪️Ansible instalado


## Ejecucion 

Para ejecutar el playbook maestro:

    ansible-playbook -i inventories/hosts.ini site.yaml --ask-become-pass

## Consideraciones

▪️ Si va a usar diferentes IP's modificar el archivo inventories/hosts.ini .
