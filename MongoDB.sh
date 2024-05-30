#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Timestamp=$(date +%F-%H-%M-%S)
LOGFILE="/temp/$0-$Timestamp.log"

echo "script started execting at $Timestamp" &>>$LOGFILE

VALIDATE(){
    if [$1 -ne 0]
    then
        echo -e "$2 ... $R Failure $N"
    else
        echo -e "$2 ... $G success $N"
    fi
}

if [$ID -ne 0]
then
    echo -e "$R Error : Please run this script with root access"
else
    echo -e "$G You are root user"
fi

cp Mongo.repo /etc/yum.repos.d/Mongo.repo &>>$LOGFILE

VALIDATE $? "copied mongoDB Repo"

yum install mongodb-org -y &>>$LOGFILE

VALIDATE $? "installing mongo db"