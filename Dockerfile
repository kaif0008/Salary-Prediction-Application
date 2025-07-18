# Base image with Java, Python, Maven, and Supervisor
FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven python3 python3-pip supervisor && \
    apt-get clean

WORKDIR /app

COPY spring-backend /app/spring-backend
RUN cd /app/spring-backend && mvn clean install

COPY ml-api /app/ml-api
RUN pip3 install -r /app/ml-api/requirements.txt

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080 5001

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
