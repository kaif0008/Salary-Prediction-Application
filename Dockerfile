# Base image with Java and Python
FROM ubuntu:22.04

# Install Java, Maven, Python, Pip, Supervisor
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven python3 python3-pip supervisor && \
    apt-get clean

# Set workdir
WORKDIR /app

# Copy Spring Boot backend
COPY spring-backend /app/spring-backend

# Build Spring Boot JAR
RUN cd /app/spring-backend && mvn clean install

# Copy Flask API
COPY ml-api /app/ml-api

# Install Flask dependencies
RUN pip3 install -r /app/ml-api/requirements.txt

# Copy Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 8080 5001

# Start both apps
CMD ["/usr/bin/supervisord"]
