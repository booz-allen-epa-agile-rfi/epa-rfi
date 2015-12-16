FROM prom/prometheus:latest

COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY alert.rules /etc/prometheus/alert.rules
COPY alertmanager.conf /etc/prometheus/alertmanager.conf

EXPOSE 9090
CMD ["/bin/bash", "startup.sh"]
