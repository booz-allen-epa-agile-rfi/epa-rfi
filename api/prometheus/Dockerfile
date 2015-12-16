FROM prom/prometheus:latest

ADD prometheus.yml /usr/src/app/
ADD alert.rules /usr/src/app/
ADD alertmanager.conf /usr/src/app/

EXPOSE 9090
CMD ["/bin/bash", "startup.sh"]
