#!/bin/bash

function prepare_enviroment() {
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r ./app/requirements.txt
}

function check_venv() {
    if [ ! -d ".venv" ]; then
        prepare_enviroment
        return
    fi
    
    if [[ "$VIRTUAL_ENV" != *".venv"* ]]; then
        source .venv/bin/activate
    fi
    
    if [ ! -f ".venv/.last_update" ] || [ requirements.txt -nt ".venv/.last_update" ]; then
        pip install -r app/requirements.txt
        touch .venv/.last_update
    fi
}

function django_commands() {
    case $1 in
        "migrate")
            python3 app/manage.py migrate --run-syncdb
            python3 app/manage.py makemigrations --noinput
            python3 app/manage.py migrate --noinput;;
        "static")
            python3 app/manage.py collectstatic --noinput;;
        "runserver")
            python3 app/manage.py runserver 0.0.0.0:8000;;
    esac
}

function docker_manager() {
    case $1 in
        "up")
            docker-compose up -d;;
        "down")
            docker-compose down;;
        "build")
            docker-compose build;;
    esac
}

function runserv() {
    cd $root_folder/app
    django_commands "migrate"
    django_commands "static"
    django_commands "runserver"
}

function show_menu() {
    clear
    echo -e "\n\n---------------------------------\n"
    echo -e "        Development Tools\n"
    echo -e "-------------------------------------\n"
    echo -e "Comandos disponíveis:\n"
    echo -e "runserv                Inicia o servidor Django\n"
    echo -e "docker_manager up      Inicia os containers Docker\n"
    echo -e "docker_manager down    Para os containers Docker\n"
    echo -e "docker_manager build   Constrói os containers Docker\n"
}

function main() {
    check_venv
    show_menu
}

function django app() {
    case $1 in
        "app")
            
        "down")
            docker-compose down;;
        "build")
            docker-compose build;;
    esac
    # Implemente a lógica para criar um novo módulo Django
    echo "Criando módulo Django: $1"
    # Adicione o comando para criar o módulo
}

main