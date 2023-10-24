# Step 1: Build the Spring Boot application using Maven
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Step 2: Create a lightweight runtime image and run the JAR file
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=build /app/target/chat-app.jar ./chat-app.jar
EXPOSE 8080 
CMD ["java", "-jar", "chat-app.jar"] 
