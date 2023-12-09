# IaC - Terraform & Ansible na AWS
Provisionando recursos de infraestrutura na AWS com Terraform e Ansible.

### Projeto
---
Nesse projeto o objetivo é subir dois ambientes (desenvolvimento e produção) com Terraform, aplicando o deploy de código com Ansible automaticamente nas máquinas.

### Objetivos
---

Principais objetivos deste projeto:

* Provisionar uma Infra minima para Dev;
* Provisionar uma Infra minima para Prod:
    * VPC e Sub-redes;
    * Grupos de Segurança;
    * LoadBalancer;
    * Autoscaling;
    * Configuração dos servidores e Deploy automático;
* Aplicar teste de carga para forçar as configurações.

### Requisitos e Softwares
---

Conhecimentos em:

- Amazon Web Services;
- Linux
- Ansible
- Terraform
- Shell Script
- python
- Locust

</br>

Softwares e Versões:


- Sistema Operacional:
```
$ hostnamectl | grep -i "operating system"
  Operating System: Ubuntu 20.04.6 LTS
```

- Ansible:
```
$ ansible --version
ansible [core 2.13.13]
```

- Terraform:
```
$ terraform -version
Terraform v1.6.5
on linux_amd64
```

- Python:
```
$ python --version
Python 3.8.10
```

- Locust:
```
$ locust --version
locust 2.19.1 from /usr/local/lib/python3.8/dist-packages/locust (python 3.8.10)
```
