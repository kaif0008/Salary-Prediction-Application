# Base image with Java, Python, Maven, and Supervisor
FROM ubuntu:22.04

# Install Java, Maven, Python, pip, and Supervisor
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven python3 python3-pip supervisor && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy and build Spring Boot app
COPY spring-backend /app/spring-backend
RUN cd /app/spring-backend && mvn clean install

# Copy ML API (Flask) and install Python dependencies
COPY ml-api /app/ml-api
RUN pip3 install -r /app/ml-api/requirements.txt \
    && pip3 install gunicorn

# Copy Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports for Spring Boot (8080) and Flask (5001)
EXPOSE 8080 5001

# Start both apps using Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
