# Postgis Docker File

No BS just works. Uses the v11 docker image, compiles postgis from source.

Use a docker-compose.yml to customize and do what you want.

Example:

```
version: '3'
services:
  db:
    build: ./bppostgis
    expose:
      - "5432"
    ports:
      - "5432:5432"
    networks:
      - default
    environment:
      - "POSTGRES_PASSWORD=password"
      - "POSTGRES_USER=postgres"
      - "POSTGRES_DB=bp"
    volumes:
      - ./bps/.setup/schema/pg:/docker-entrypoint-initdb.d/   
```

## Collaborating
Example bash commands:

```
sudo docker login -u sfproductlabs docker.io
sudo docker tag bp_db:latest sfproductlabs/postgis:latest
sudo docker push sfproductlabs/postgis:latest
```

