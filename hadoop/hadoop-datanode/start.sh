#!/bin/bash

/usr/sbin/sshd

echo -e "\e[01;32m*\e[00m `date` \e[01;32mWaiting on datanode to ensure namenode and Hive are up\e[00m"

sleep 15

if ! $(hadoop fs -test -d /user/hive/warehouse/maf_transaccion); then
  for i in {04,05,06,07,08,09}
  do
    echo -e "Sqooping maf_transaccion table into hive"
    sqoop import --connect jdbc:postgresql://10.60.227.13:5432/maf --hive-table maf_transaccion$i --target-dir "/tmp/data$i" --create-hive-table \
    --query "SELECT * FROM maf_transaccion WHERE fecha_creacion >='2018-$i-01' AND fecha_creacion < '2018-$((i+1))-01' AND \$CONDITIONS" \
    --username maf --password MAF_uaDYjiiILdG --hive-import -m1 --map-column-hive ids_transacciones_similares=STRING,ids_transacciones_similares_comercio=STRING
  done
fi


echo -e "\e[01;32m*\e[00m `date` \e[01;32mStarted DataNode\e[00m"

sleep 31536000 # sleep for a year so the process doesn't exit
