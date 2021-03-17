![packer-validate](https://github.com/Otus-DevOps-2020-11/dmnbars_infra/actions/workflows/packer-validate.yml/badge.svg)
![terraform-validate](https://github.com/Otus-DevOps-2020-11/dmnbars_infra/actions/workflows/terraform-validate.yml/badge.svg)
![tflint](https://github.com/Otus-DevOps-2020-11/dmnbars_infra/actions/workflows/tflint.yml/badge.svg)
![tests](https://github.com/Otus-DevOps-2020-11/dmnbars_infra/actions/workflows/run-tests.yml/badge.svg)

# dmnbars_infra
dmnbars Infra repository

## Cloud bastion homework

```
bastion_IP = 178.154.252.46
someinternalhost_IP = 10.130.0.34
```

### Подключение к `someinternalhost` в одну команду из вашего рабочего устройства
```shell
ssh -A -i ~/.ssh/otus-yandex-cloud -J appuser@178.154.252.46 appuser@10.130.0.34
```

### Подключения из консоли при помощи команды вида ssh `someinternalhost` из локальной консоли
добавить в `~/.ssh/config`
```
Host otus-yc-bastion-host
    User appuser
    HostName 178.154.252.46
    IdentityFile ~/.ssh/otus-yandex-cloud

Host someinternalhost
    User appuser
    HostName 10.130.0.34
    IdentityFile ~/.ssh/otus-yandex-cloud
    ProxyJump otus-yc-bastion-host
```
после этого выполнить
```shell
ssh someinternalhost
```

## Cloud testapp homework

```
testapp_IP = 178.154.246.59
testapp_port = 9292
```

### CLI комманда для создания инстанса с использованием startup script для деплоя `reddit-app`
```shell
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=metadata.yaml
```

## Packer base homework
 * Добавлен [конфиг packer](packer/ubuntu16.json) для сборки базового образа reddit-base
 * Добавлен [конфиг packer](packer/immutable.json) для сборки полного baked образа reddit-full
 * Добавлен [скрипт](config-scripts/create-reddit-vm.sh) для создния vm инстанса с reddit-app

## Terraform homework №2

### Задание со *
 * Создал новый бакет для хранения стейта терраформа
 * Создал для сервисного аккаунта новый статический ключ доступа
 * Описал конфигурацию бекенда за исключением `access_key` и `secret_key` в файлах `terraform/prod/backend.tf` и `terraform/stage/backend.tf`
 * `access_key` и `secret_key` описал в файле `terraform/backend_creds.tf`
 * Сдублировал конфиг терраформа в отдельную папку вне репозитория
 * Инитил терраформ командой `terraform init -backend-config=../backend_creds.tf` для папки `terraform/prod` и с измененным путем до `backend_creds.tf` для второй версии конфигурации.

### Задание с **
 * Добавил provisioners для модуля app с конфигом для systemd и скриптом деплоя приложения
 * В `terraform/modules/app/files/puma.service` добавлен `Environment` для проброса url для mongodb
 * Модуль db теперь ожидает получения переменной db_url, которая строится из внутреннего ip инстанса с базой
 * В provisioner для модуля db добавлено изменение конфигурации mongodb и ее рестарт
 * Запуск provisioners теперь зависит от переменной `deploy_app`, реализованно с помощью использования `null_resource` и `count`

## Ansible homework №1

### Задание со *
 * Разница между форматом статического и динамического json inventory видна в файлах `ansible/inventory_dynamic.json` и `ansible/inventory.json`
 * Скрипт `ansible/inventory.py` берет файл `ansible/inventory.json` (статический формат) и преобразует его в динамический формат

## Ansible homework №2

### Задание
 * Написан деплой по принципу "один playbook, один сценарий" - `ansible/reddit_app_one_play.yml`
 * Написан деплой по принципу "один playbook, несколько сценариев" - `ansible/reddit_app_multiple_plays.yml`
 * Написан деплой по принципу "несколько playbooks" - `ansible/site.yml`, `ansible/db.yml`, `ansible/app.yml`, `ansible/deploy.yml
 * Написаны ansible provisioners для создания packer образов app и db

### Задание со *
 * Написан новый ansible dynamic inventory - `ansilbe/inventory_terraform.py`.
 * Данные для hosts и vars берутся из вывода terraform output
 * Не думаю, что это самый "оптимальный" способ, но так как конфиг и стейт терраформа находится в этом же проекте, то на мой взгляд этот способ очень прост)
