# voice_monitoring
Voice monitoring of the availability of hosts

#ru# Как работает данный скрипт мониторинга:
1) Скрипт проходит по списку ip адресов хостов, проверяет доступ по ping.
2) Если какой-то из хостов недоступен, подключается голосовое оповещение о недоступности
3) Отправляется оповещение в jabber
4) фича! Случайным образом из словоря заранее заготовленных фраз произносится не смешная шутка с сарказмом.

#ru# Для работы скрипта необходимо:
1) Установить пакеты:
festival , festvox-ru, speech-tools, sendxmpp, snmp
2) Поставить скрипт на выполнение по cron, например запуск каждые 5 минут.


#en# How this monitoring script works:
1) The script goes through the list of ip addresses of hosts, checks access by ping.
2) If any of the hosts is unavailable, a voice alert about unavailability is activated.
3) An alert is sent to jabber
4) feature! Randomly from the dictionary pre-prepared phrases pronounced is not a funny joke with sarcasm.

#en# For the script to work:
1) Install packages:
festival, festvox-en, speech-tools, sendxmpp, snmp
2) Put the script on execution by cron, for example, run every 5 minutes.


