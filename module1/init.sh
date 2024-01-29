# go to directory
cd /workspaces/de-zoomcamp2024/module1

# start with a fresh docker system
docker system prune -a y

# start up docker-compose
docker-compose up

# create docker network to connect Postgres and pgAdmin
docker network create pg-network
# run Postgres in the network
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v /workspaces/de-zoomcamp2024/module1/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13
# run pgAdmin in the network
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin-2 \
  dpage/pgadmin4

# ingest data from source
URL_TRIPS="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
URL_ZONES="https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"

# ingest trip data
python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=green_taxi_trips \
  --url=${URL_TRIPS}

# ingest zone data
python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=zones \
  --url=${URL_ZONES}
