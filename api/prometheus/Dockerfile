FROM prom/prometheus:latest

ADD prometheus.yml /etc/prometheus/
ADD alert.rules /etc/prometheus/
ADD alertmanager.conf /etc/prometheus/

EXPOSE 9090

CMD ["/bin/sh", "startup.sh"]
