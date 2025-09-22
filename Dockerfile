# -------- Stage 1: Build --------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Create a non-root user
RUN groupadd -g 1000 appgroup && useradd -u 1000 -g appgroup -m appuser

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

# -------- Stage 2: Runtime --------
FROM openjdk:17-jre-slim

# Create a non-root user (for the runtime stage)
RUN groupadd -g 1000 appgroup && useradd -u 1000 -g appgroup -m appu
