FROM --platform=linux/amd64 postgres:11.5

LABEL maintainer="kevinity310"

# Add user 'root' with password 'your_password'
ENV POSTGRES_USER=root
ENV POSTGRES_PASSWORD=root
ENV POSTGRES_DB=postgres

# Copy the SQL script into the container
COPY script.sql /docker-entrypoint-initdb.d/

# Change the permission of the script to ensure it's executable
RUN chmod +r /docker-entrypoint-initdb.d/script.sql

EXPOSE 5432

# docker build -t kevinity310/pg-metastore:dev .
# docker run -it --rm --name pg-hive kevinity310/pg-hive:dev /bin/bash 

# Note : user 'postgres' with password 'postgres' is created in the container.