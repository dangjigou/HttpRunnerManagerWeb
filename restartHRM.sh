#!/bin/bash
for i in `ps -ef | grep python | awk '{print $2}'`
do
        kill $i
done
nohup rabbitmq-server >> /usr/logs/hrm.out 2>&1 &
sleep 5
nohup python3 /usr/HttpRunnerManager/manage.py celery -A HttpRunnerManager worker --loglevel=info >> /usr/logs/hrm.out 2>&1 &
sleep 5
nohup python3 /usr/HttpRunnerManager/manage.py celery beat --loglevel=info >> /usr/logs/hrm.out 2>&1 &
sleep 5
nohup python3 /usr/HttpRunnerManager/manage.py celery flower >> /usr/logs/hrm.out 2>&1 &
sleep 5
nohup python3 /usr/HttpRunnerManager/manage.py runserver 0.0.0.0:80 >> /usr/logs/hrm.out 2>&1 &