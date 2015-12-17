FROM postgres

RUN mkdir -p /usr/src/app/dbdata
WORKDIR /usr/src/app/dbdata
COPY *.txt /usr/src/app/dbdata/
RUN psql -f epa_records.sql