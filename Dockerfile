# Base image with Java, Python, Maven, and Supervisor
FROM ubuntu:22.04

# Install Java, Maven, Python, Pip, and Supervisor
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven python3 python3-pip supervisor && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy and build Spring Boot app
COPY spring-backend /app/spring-backend
RUN cd /app/spring-backend && mvn clean install

# Copy Flask app and install requirements
COPY ml-api /app/ml-api
RUN pip3 install -r /app/ml-api/requirements.txt

# Copy Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports for both apps
EXPOSE 8080

# Start Supervisor to run both apps
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
