#!/bin/bash
env="development"
host="0.0.0.0"
aqport=3000
krillport=3500

AQPID=` lsof -wnitcp:$aqport | grep 'ruby' | head -1 | tr -s ' ' | cut -d ' ' -f 2`
KRILLPID=` lsof -wnitcp:$krillport | grep 'ruby' | head -1 | tr -s ' ' | cut -d ' ' -f 2`

echo "======================"
echo "Restarting Aquarium..."
echo "======================"
echo "Aquarium Server"
echo "   Port: $aqport"
echo "   PID: $AQPID"
echo "Krill Server"
echo "   Port: $krillport"
echo "   PID: $KRILLPID"

echo "------------------"

# Kill servers
restartAQ=0
restartKRILL=0
if [ -z $AQPID ]
then
    echo "No Aquarium server running on port $aqport"
else
    kill -9 $AQPID
    echo "Killed Aquarium server on $AQPID"
    restartAQ=1
fi

if [ -z $KRILLPID ]
then
    echo "No Krill server running on port $krillport"
else
    kill -9 $KRILLPID
    echo "Killed Krill server with PID $AQPID"
    restartKRILL=1
fi


# Restart Servers
echo ""
echo "Restarting servers..."
RAILS_ENV=$env rails s &
rails runner "Krill::Server.new.run(3500)" &
jobs

# Wait 5 seconds
for i in {1..50}
do
  echo -ne '.'
  sleep .1
done

# Open Aquarium Webpage
printf "\n\n================\nOpening Aquarium\n"
open "http://$host:$aqport"