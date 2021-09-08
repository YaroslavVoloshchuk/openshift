#!/bin/bash

export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%Y-%m-%d"`

DB_BACKUP_PATH='/home/bamik/mongo'
MONGO_HOST='localhost'
MONGO_PORT='27018'

AUTH_ENABLED=0
MONGO_USER=$MONGOUSER
MONGO_PASSWD=$MONGOPWD

DATABASE_NAMES='ALL'

BACKUP_RETAIN_DAYS=30 

mkdir -p ${DB_BACKUP_PATH}/${TODAY}
 
AUTH_PARAM=""
 
if [ ${AUTH_ENABLED} -eq 1 ]; then
 AUTH_PARAM=" --username ${MONGO_USER} --password ${MONGO_PASSWD} "
fi
 
if [ ${DATABASE_NAMES} = "ALL" ]; then
 echo "You have choose to backup all databases"
 mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/
else
 echo "Running backup for selected databases"
 for DB_NAME in ${DATABASE_NAMES}
 do
 mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} --db ${DB_NAME} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/
 done
fi

DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

#cron 0 2 * * * /backup/mongobackup.sh
