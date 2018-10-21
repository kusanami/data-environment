#!/bin/bash

/usr/sbin/sshd

echo -e "\e[01;32m*\e[00m `date` \e[01;32mWaiting on datanode to ensure namenode and Hive are up\e[00m"

sleep 15

if ! $(hadoop fs -test -d /user/hive/warehouse/matches); then
  echo -e "Sqooping matches table into hive"
  sqoop import --connect jdbc:postgresql://10.60.227.13:5432/maf --table matches --username maf --password MAF_uaDYjiiILdG --query "SELECT * FROM maf.maf_transaccion WHERE fecha_creacion > '2018-04-01'" --create-hive-table --hive-import -m1
fi

echo -e "\e[01;32m*\e[00m `date` \e[01;32mStarted DataNode\e[00m"

sleep 31536000 # sleep for a year so the process doesn't exit
