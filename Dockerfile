# Use a Java JDK base image to build the app
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# Copy Gradle wrapper and build scripts
COPY gradlew build.gradle settings.gradle ./
COPY gradle gradle

# Copy the source code
COPY src src

# Build the jar
RUN ./gradlew clean build --no-daemon

# Use only the JAR in the final image
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=builder /app/build/libs/hello-0.0.1-SNAPSHOT.jar app.jar

# Run the JAR
CMD ["java", "-jar", "app.jar"]
