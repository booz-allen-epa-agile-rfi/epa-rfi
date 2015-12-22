#!/bin/bash

set -e

CALLEDUP="false"

# Wait until the bees are up and all setup and ready to attack
while true; do

        if [ -z "`bees report | grep running | awk '{print $5}'`" ]; then

                if [ "$CALLEDUP" = "false" ]; then

                        echo "************ ASSEMBLING THE ARMY ************"
                        /usr/local/bin/bees up -s $KILLER_BEES -k beeswarm -i ami-6989a659 -z us-west-2c -g bees -l ubuntu

                        CALLEDUP="true"
                fi

                echo "Waiting 15 seconds for bees to wake up..."
                sleep 15
        else

                # If this is the first time the bees have been called up
                if [ ! -f ~/.bees.setup.log ]; then

                        echo "********* ARMING THE BEES FOR BATTLE *********"
                        # Install run apt-get update and then install apache2-utils so the bee will have Apache Bench
                        bees report | grep running | awk '{print $5}' | \
                        tr '\n' '\0' | \
                        xargs -0 -n1 -I server \
                        ssh -o UserKnownHostsFile=/dev/null \
                            -o StrictHostKeyChecking=no \
                            -i ~/.ssh/beeswarm.pem ubuntu@server 'sudo apt-get update && sudo apt-get install apache2-utils -y' \
                        > ~/.bees.setup.log
                fi

                break;
        fi
done

echo "********** ATTACKING THE TARGET ***********"
/usr/local/bin/bees attack -n $TOTAL_BULLETS -c $BULLETS_PER_SWARM -u $TARGET_URL || :

echo "************ BEES GOING DOWN **************"
/usr/local/bin/bees down

rm -f -v ~/.bees.setup.log
