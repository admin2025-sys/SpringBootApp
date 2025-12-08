# -------- Stage 1: Build --------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

# -------- Stage 2: Run --------
FROM eclipse-temurin:17-jre-alpine

COPY --from=builder /app/target/*.jar /app/bankapp.jar

EXPOSE 8082
CMD ["java", "-jar", "/app/bankapp.jar"]
