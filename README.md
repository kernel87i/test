## Задача

* Создать VPS с помощью Terraform
* Написать роль Ansible  для установки на разные платформы в зависимости от ansible_os_family, используя зависимости, роль для виртуального хоста c проксированием на backend. Установить готовую роль prometheus. Настроить проксирование через Nginx и настроить  базовую аутентификацию HTTP через .htpasswd
* Необходимо установить Ansible-lint и произвести проверку и корректировку playbook и roles в соответствии с выводом

## Предпосылки

* Установить terraform
* Установить Go 1.13 (to build the provider plugin)
* Собрать плагин terraform для vscale
* Установить ansible https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

## Развертывание

* Конфигурируем main.tf (создаем ресурс в Vscale)
* Выносим описание variables  в отдельный файл variables.tf
* Описываем в фале outputs.tf выводимые значения
* Переменные объявляем в файле terraform.tfvars (В файле объявляем токен, имя образа, Id дата-центра,secret_key, access_key для AWS, регион для AWS)
* В файле terraform.tfvars.sample описано назначение переменных
* Развертываем 2 роли: deploy_ngix и virtal_host. Для роли deploy_ngix используем dependencies  в зависимости от платформы 
* C помощью сервиса ansible-galaxy скачать роль william-yeh.prometheus, защищаем подключение с помощью .htpasswd

## Ansible Roles

* Первая роль deploy_nginx для установки дефолтного Nginx в зависимости от платформы, используя dependencies
  *  dependencies_redhat для предварительной установки на centos
  *  dependencies_debian для предварительной установки на ubuntu

* Вторая роль virtual_host для деплоя виртуального хоста
* Третья роль william-yeh.prometheus
  *  Поготовить requirements.yml
  *  Установим переменную ANSIBLE_ROLES_PATH в ansible.cfg
  *  Установить роль: ansible-galaxy install -p roles/ -r roles/requirements.yml

## Проверка корректности playbook и  roles

* ansible-lint playbook.yml

## Подключаемся по ssh.

* ssh root@92.53.66.226
* ssh root@95.213.199.216

## Проверяем подключение по 80 порту к виртуальным хостам.  

*  curl 92.53.66.226
*  curl 95.213.199.216


## Авторы

  - Sergey Babanin https://gitlab.rebrainme.com/babaninsergey

