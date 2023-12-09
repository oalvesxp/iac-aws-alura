#!/bin/bash
cd /home/ubuntu
sudo apt update -y
sudo apt install python3 -y
sudo apt install python3-pip -y
sudo pip3 install ansible
tee -a playbook.yml > /dev/null <<EOT
---
  - hosts: localhost
    gather_facts: True

    tasks:
    - name: Git clone
      ansible.builtin.git:
        repo: https://github.com/guilhermeonrails/clientes-leo-api.git
        dest: '$HOME/tcc'
        version: master
        force: yes

    - name: Criando a venv e instalando dependências
      pip:
        virtualenv: '$HOME/tcc/venv'
        requirements: '$HOME/tcc/requirements.txt'

    - name: Alterando o hosts settings
      lineinfile:
        path: '$HOME/tcc/setup/settings.py'
        regexp: 'ALLOWED_HOSTS'
        line: "ALLOWED_HOSTS = ['*']"
        backrefs: yes

    - name: Configurando o bando de dados
      shell: '. $HOME/tcc/venv/bin/activate; python $HOME/tcc/manage.py migrate'

    - name: Carregando os dados
      shell: '. $HOME/tcc/venv/bin/activate; python $HOME/tcc/manage.py loaddata clientes.json'

    - name: Iniciando o ambiente
      shell: '. $HOME/tcc/venv/bin/activate; nohup python $HOME/tcc/manage.py runserver 0.0.0.0:8000 &'
EOT
ansible-playbook playbook.yml