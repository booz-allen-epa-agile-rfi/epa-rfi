#until nc -z db 5432
#do
#    echo "Waiting for the database container..."
#    sleep 0.5
#done
# Temporary solution - sleep for 60 seconds
sleep 60
rake db:reset
export SECRET_KEY_BASE='rake secret'

# We want to make sure rails doesn't trip over any existing rails process and/or pid
if [ -f /usr/src/app/tmp/pids/server.pid ]; then

        echo "server.pid exists, so let's get rid of it so rails won't complain and cause an exit."
        rm /usr/src/app/tmp/pids/server.pid
fi

rails s -b 0.0.0.0 -p 3000
