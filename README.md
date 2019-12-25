## Задача

* Создать 2 VPS с помощью Terraform
* Установить Nginx на каждую ноду.  Первую ноду сделать как load balancer настроив проксирование на второй хост используя proxy_pass + upstream. Вторую ноду настроить как сервер приложения с любым статическим html.
* Динамически сформировать файл inventory c помощью функции terraformfile, запустить деплой ansible-playbook c помощью local-exec

## Предпосылки

* Установить terraform 
* Установить Go 1.13 (to build the provider plugin)
* Собрать плагин terraform для vscale
* Установить ansible https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

## Развертывание

* Конфигурируем main.tf (создаем ресурсы в Vscale)
* Выносим описание variables  в отдельный файл variables.tf
* Описываем в фале outputs.tf выводимые значения
* Переменные объявляем в файле terraform.tfvars (В файле объявляем токен, имя образа, Id дата-центра,secret_key, access_key для AWS, регион для AWS)
* В файле terraform.tfvars.sample описано назначение переменных
* Развертываем 2 роли: deploy_nginx_lb и deploy_nginx_backend. Для ролей используем dependencies  в зависимости от платформы 


## Ansible Roles

* Первая роль deploy_nginx_lb для установки  Nginx и настройки его в качестве load-balancer на второй хост.
  *  dependencies_redhat для предварительной установки на centos

* Вторая роль deploy_nginx_backend для деплоя виртуального хоста
  *  dependencies_debian для предварительной установки на ubuntu


## Подключаемся по ssh.

* ssh root@79.143.31.113
* ssh root@37.228.116.95

## Проверяем подключение по 80 порту к load-balancer.  

*  curl 79.143.31.113
*  curl 37.228.116.95


## Авторы

  - Sergey Babanin https://gitlab.rebrainme.com/babaninsergey

