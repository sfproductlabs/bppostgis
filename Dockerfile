
FROM postgres:11
MAINTAINER Andrew Grosser <dioptre@gmail.com>


ENV POSTGRES_PASSWORD password
ENV POSTGRES_USER postgres
ENV POSTGRES_DB sfpl
ENV LOCAL_SCHEMA_DIRECTORY ./schema


# RUNNING SCHEMA SETUP
#
## Setup in docker-compose.yml INSTEAD
# Ex.
#   db:
#     build: ./bppostgis
#     expose:
#       - "5432"
#     ports:
#       - "5432:5432"
#     networks:
#       - default
#     environment:
#       - "POSTGRES_PASSWORD=password"
#       - "POSTGRES_USER=postgres"
#       - "POSTGRES_DB=sfpl"
#     volumes:
#       - ../bps/.setup/schema/pg:/docker-entrypoint-initdb.d/ 
## Or do it here if you have to
# WORKDIR /docker-entrypoint-initdb.d
# ADD $LOCAL_SCHEMA_DIRECTORY /docker-entrypoint-initdb.d
# RUN bash -e `psql -U postgres -f 1-schema.sql`
# RUN bash -e `psql -U postgres -f 2-schema.sql`
# RUN bash -e `psql -U postgres -f 99-data.sql`


EXPOSE 5432

RUN apt update \
      && apt install -y --no-install-recommends \
           libgdal-dev build-essential wget postgresql-server-dev-11 libxml2-dev\
      && rm -rf /var/lib/apt/lists/*


WORKDIR /postgis-2.5.4dev
RUN wget http://postgis.net/stuff/postgis-2.5.4dev.tar.gz
RUN tar -xvzf postgis-2.5.4dev.tar.gz
RUN ./configure
RUN make
RUN make install
