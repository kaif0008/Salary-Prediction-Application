# Base image
FROM ubuntu:22.04

# Install Java, Maven, Python, Pip, Supervisor
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven python3 python3-pip supervisor && \
    apt-get clean

# Set workdir
WORKDIR /app

# Copy Spring Boot source code
COPY spring-backend /app/spring-backend

# Build Spring Boot JAR
RUN cd /app/spring-backend && mvn clean install

# Copy Flask API
COPY ml-api /app/ml-api

# Install Flask requirements
RUN pip3 install -r /app/ml-api/requirements.txt

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 8080
EXPOSE 5001

# Start both services
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
