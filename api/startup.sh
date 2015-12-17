#until nc -z db 5432
#do
#    echo "Waiting for the database container..."
#    sleep 0.5
#done
# Temporary solution - sleep for 60 seconds
sleep 60
rake db:reset
export SECRET_KEY_BASE='rake secret'
rails s -b 0.0.0.0 -p 3000
