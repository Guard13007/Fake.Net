#!/bin/bash

echo "This script doesn't work."
exit 1 #THIS SCRIPT DOESN'T WORK OKAY?

#this is just so sudo is ready to be used without asking for a password again
sudo echo

#and this is where that is needed
bash -c "sudo -i -u postgres & postgres -D '/var/lib/postgres/data'" &
pid=$!
echo "PostgreSQL started. PID=$pid"
PID_LIST="$pid"

#always run migrations just in case
lapis migrate & lapis server development &
pid=$!
echo "Lapis started. PID=$pid"
PID_LIST+=" $pid"

#this will need to be re-started at some point :/
moonc -w . &
pid=$!
echo "moonc watch started. PID=$pid"
PID_LIST+=" $pid"

#two SIGINTs because moonc needs two
trap "kill $PID_LIST" SIGINT SIGINT
echo "All processes started."
wait $PID_LIST
echo "All processes deaded."
