#until nc -z db 5432
#do
#    echo "Waiting for the database container..."
#    sleep 0.5
#done
# Temporary solution - sleep for 60 seconds
sleep 60
rspec
rake db:reset
export SECRET_KEY_BASE='rake secret'

# We want to make sure rails doesn't trip over any existing rails process and/or pid
if [ ! -f /usr/src/app/tmp/pids/server.pid ]; then

        echo "server.pid did not exist, so we can start up rails cleanly"
else
        SERVER_PID = `cat /usr/src/app/tmp/pids/server.pid`
        PROCESS_ID = `ps -ef | grep rails | grep $SERVER_PID | awk '{print $2}'`

        if [ "$SERVER_PID" == "$PROCESS_ID" ]
            kill -9 $PROCESS_ID 
        fi 

        rm /usr/src/app/tmp/pids/server.pid
fi

rails s -b 0.0.0.0 -p 3000
