# Use an official PHP runtime as a parent image
FROM php:7.4-apache

# Set the working directory
WORKDIR /var/www/html

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy the current directory contents into the container at /var/www/html
COPY . .

# Expose port 80 to the host
EXPOSE 80
