# dmnbars_infra
dmnbars Infra repository

### Подключение к `someinternalhost` в одну команду из вашего рабочего устройства
```shell
ssh -A -i ~/.ssh/otus-yandex-cloud -J appuser@178.154.252.46 appuser@10.130.0.34
```
где:
 * `~/.ssh/otus-yandex-cloud` - путь ssh ключа для доступа к серверам
 * `178.154.252.46` - внешний ip адрес `bastion` сервера
 * `10.130.0.34` - внутренний ip адрес `someinternalhost`

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
