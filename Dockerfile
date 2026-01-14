# Bước 1: Build project bằng Gradle với JDK 21
FROM gradle:8.5-jdk21 AS build
WORKDIR /app
COPY . .

# Cấp quyền thực thi cho gradlew
RUN chmod +x gradlew

# Chạy lệnh build
RUN ./gradlew bootJar --no-daemon

# Bước 2: Chạy ứng dụng với Java 21 Runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Copy file jar từ bước build
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
