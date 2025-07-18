FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven python3 python3-pip && \
    apt-get clean

WORKDIR /app

# Build Spring Boot app
COPY spring-backend /app/spring-backend
RUN cd /app/spring-backend && mvn clean install

# Set up Flask (ML API)
COPY ml-api /app/ml-api
RUN pip3 install -r /app/ml-api/requirements.txt

# Expose Spring Boot’s port
EXPOSE 8080

# Start Spring Boot as the primary process
CMD ["java", "-jar", "/app/spring-backend/target/salarypredict-0.0.1-SNAPSHOT.jar"]
