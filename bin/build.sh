#!/bin/bash
set -e

echo "******* BUILDING DATABASE CONTAINER *******"
docker build -t database ../postgres
docker run --name pgdb -p 5432:5432 -d database

echo "******* BUILDING BACKEND CONTAINER ********"
docker build -t api ../api
docker run -p 3000:3000 --link pgdb:db -e "RAILS_ENV=docker" -d api

echo "******* BUILDING FRONTEND CONTAINER *******"
docker build -t frontend ../www
docker run -p 9000:9000 -d frontend
