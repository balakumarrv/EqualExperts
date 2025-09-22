# -------- Stage 1: Build --------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Create a non-root user
ARG USERNAME=appuser
ARG UID=1000
RUN adduser --uid $UID --disabled-password --gecos "" $USERNAME

WORKDIR /app

# Switch to non-root user
USER $USERNAME

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

# -------- Stage 2: Runtime --------
FROM eclipse-temurin:17-jre-alpine

# Create same non-root user in runtime stage
ARG USERNAME=appuser
ARG UID=1000
RUN adduser -u $UID -D -S $USERNAME

WORKDIR /app

# Switch to non-root user
USER $USERNAME

COPY --from=build /app/target/gist-api-java-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
