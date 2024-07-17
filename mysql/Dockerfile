# Use the official MySQL base image
FROM mysql:5.7

# Copy the initialization script into the container
COPY init.sql /docker-entrypoint-initdb.d/

# Environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=blog
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=root

# Expose port 3306 to the outside world
EXPOSE 3306
