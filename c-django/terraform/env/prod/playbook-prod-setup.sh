#!/bin/bash
cd /home/ubuntu
sudo apt update -y
sudo apt install python3 python3-pip virtualenv ansible -y 
tee -a playbook.yml > /dev/null <<EOT
---
  - hosts: localhost
    gather_facts: True

    tasks:
    - name: Git clone
      ansible.builtin.git:
        repo: https://github.com/guilhermeonrails/clientes-leo-api.git
        dest: '/home/ubuntu/tcc'
        version: master
        force: yes

    - name: Criando a venv e instalando dependências
      pip:
        virtualenv: '/home/ubuntu/tcc/venv'
        requirements: '/home/ubuntu/tcc/requirements.txt'

    - name: Alterando o hosts settings
      lineinfile:
        path: '/home/ubuntu/tcc/setup/settings.py'
        regexp: 'ALLOWED_HOSTS'
        line: "ALLOWED_HOSTS = ['*']"
        backrefs: yes

    - name: Configurando o bando de dados
      shell: '. /home/ubuntu/tcc/venv/bin/activate; python /home/ubuntu/tcc/manage.py migrate'

    - name: Carregando os dados
      shell: '. /home/ubuntu/tcc/venv/bin/activate; python /home/ubuntu/tcc/manage.py loaddata clientes.json'

    - name: Iniciando o ambiente
      shell: '. /home/ubuntu/tcc/venv/bin/activate; nohup python /home/ubuntu/tcc/manage.py runserver 0.0.0.0:8000 &'
EOT
ansible-playbook playbook.yml
