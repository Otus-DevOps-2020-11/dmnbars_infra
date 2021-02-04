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
