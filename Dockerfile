# -------- Stage 1: Build --------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Create a non-root user for build stage
ARG USERNAME=appuser
ARG UID=1000
RUN adduser --uid $UID --disabled-password --gecos "" $USERNAME

# Set working directory and ensure proper permissions
WORKDIR /app
RUN chown -R $USERNAME:$USERNAME /app

# Switch to non-root user
USER $USERNAME

# Copy pom.xml and download dependencies first (faster rebuilds)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# -------- Stage 2: Runtime --------
FROM eclipse-temurin:17-jre-alpine

# Create a non-root user for runtime stage
ARG USERNAME=appuser
ARG UID=1000
RUN adduser -u $UID -D -S $USERNAME

# Set working directory and permissions
WORKDIR /app
RUN chown -R $USERNAME:$USERNAME /app

# Switch to non-root user
USER $USERNAME

# Copy the built jar from the build stage
COPY --from=build /app/target/gist-api-java-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
