#!/bin/bash

###############################################
#                                             #
#        Voice monitoring script v2.5         #
#                                             #
###############################################

#ru# Список хостов через разделенные пробелом, доступность узла определяется по ping.
#en# The list of hosts separated by a space, the node availability is determined by ping.
HostGroup1="192.168.35.1 192.168.35.2 192.168.35.3 192.168.35.5"

#ru# Список хостов разделенные пробелом, мониторинг чего-нибудь по snmp.
#en# The list of hosts separated by a space, monitoring something on snmp.
HostGroup2="192.168.15.5 192.168.15.6 192.168.15.34 192.168.15.34"


#ru# Случайное целое число для random реплики. ( C добавлением новых фраз нужно увеличить range от нуля до + количество добавленных фраз. )
#en# Random integer for random replicas. (With the addition of new phrases, you need to increase the range from zero to + the number of added phrases.)
random_roll=`echo "$((0 + RANDOM % 19))"`


#ru# Словарь случайных реплик
#en# Random Replica Dictionary
speech1="Но, это, не точно!"
speech2="Советую, проверить!"
speech3="Вам скоро позвонят?"
speech4="Восстание машин уже близко!"
speech5="Скоро я это повторю!"
speech6="А в столовой сегодня макароны!"
speech7="Может быть перезагрузим?"
speech8="Выше нос, ку сок мяса!"
speech9="Всё проверили, ни чего, не работает!"
speech10="Опять вы всё сломали?"
speech11="Время пошло!"
speech12="Это не шутки!"
speech13="Кто, сломал?"
speech14="Кра бы!"
speech15="Шо, опять?"
speech16="Куда пропало твое настроение?"
speech17="Самое время выключить, телефон!"
speech18="брлллрбблрллр!"
speech19="Восстание машин уже началось!"


#ru# Функция для определения случайной фразы из словоря. ( С добавлением новых фраз нужно увеличить цифру сравнения -gt на + количество добавленных фраз, и добавить новый elif с новым порядковым номером фразы. )
#en# The function for determining a random phrase from the dictionary. (With the addition of new phrases, you need to increase the comparison number -gt by + the number of added phrases, and add a new elif with a new sequence number.)

function random_speech {

random_roll2=`date +%S | cut -c 2-2`;

if [ $(($random_roll + $random_roll2)) -gt 19 ] ; then
        echo "$speech19" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 1 ] ; then
        echo "$speech1" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 2 ] ; then
        echo "$speech2" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 3 ] ; then
        echo "$speech3" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 4 ] ; then
        echo "$speech4" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 5 ] ; then
        echo "$speech5" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 6 ] ; then
        echo "$speech6" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 7 ] ; then
        echo "$speech7" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 8 ] ; then
        echo "$speech8" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 9 ] ; then
        echo "$speech9" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 10 ] ; then
        echo "$speech10" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 11 ] ; then
        echo "$speech11" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 12 ] ; then
        echo "$speech12" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 13 ] ; then
        echo "$speech13" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 14 ] ; then
        echo "$speech14" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 15 ] ; then
        echo "$speech15" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 16 ] ; then
        echo "$speech16" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 17 ] ; then
        echo "$speech17" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 18 ] ; then
        echo "$speech18" | festival --tts --language russian
elif [ $(($random_roll + $random_roll2)) -eq 19 ] ; then
        echo "$speech19" | festival --tts --language russian
fi
}



#ru# Реплика для HostGroup1
#en# Replica for HostGroup1
function voice_HostGroup1 {
echo "хост не доступен!" | festival --tts --language russian
echo $mhost | sed -r -e 's/[.]/ /g' | festival --tts --language russian
echo "Повторяю!" | festival --tts --language russian
echo $mhost | sed -r -e 's/[.]/ /g' | festival --tts --language russian
random_speech
echo "[`date +%F/%H:%M:%S`] HostGroup1 host ip address $mhost не доступен!" | sendxmpp username1@jabber.com username2@jabber.com username3@jabber.com
}

#ru# Реплика для HostGroup2
#en# Replica for HostGroup2
function voice_HostGroup2 {
echo "Пропал линк на порту!" | festival --tts --language russian
echo $mhost | sed -r -e 's/[.]/ /g' | festival --tts --language russian
echo "Повторяю!" | festival --tts --language russian
echo $mhost | sed -r -e 's/[.]/ /g' | festival --tts --language russian
random_speech
echo "[`date +%F/%H:%M:%S`] HostGroup2 cisco catalyst $mhost  нет линка на порту 8!" | sendxmpp username1@jabber.com username2@jabber.com username3@jabber.com
}


#ru# Количество пингов для проверки доступности
#en# Number of pings to check availability
COUNT=1

#ru# Определение доступности хоста по ping
#en# Determining the availability of a host by ping
for mhost in $HostGroup1
do
count=$(ping -c $COUNT $mhost | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
if [ $count -eq 0 ]; then
echo $mhost | egrep "." > /dev/null
if [ $? -eq 0 ]; then
voice_HostGroup1
fi
fi
done

#ru# Определение состояния чего-нибудь по snmp (в примере наличие линка на порту cisco 1-нет линка, 2-есть линк)
#en# Determining the state of something by snmp (in the example, the presence of a link on the port cisco 1 is no link, 2 is a link)
for mhost in $HostGroup2
do
if link_state=`snmpwalk -v 2c -c public $mhost 1.3.6.1.2.1.2.2.1.8.8`; then
if [ "$lin_kstate" -lt 2 ]; then
voice_HostGroup2
fi
fi
done
