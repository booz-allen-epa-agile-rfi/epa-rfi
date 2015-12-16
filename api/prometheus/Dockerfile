FROM prom/prometheus:latest

RUN apt-get update -y && \
  apt-get install -y \
  --no-install-recommends && rm -rf /var/lib/apt/lists/* 

COPY prometheus.yml /etc/prometheus/prometheus.yml
COPY alert.rules /etc/prometheus/alert.rules
COPY alertmanager.conf /etc/prometheus/alertmanager.conf

EXPOSE 9090
CMD ["/bin/bash", "startup.sh"]
