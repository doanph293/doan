# Bước 1: Build project bằng Gradle
FROM gradle:8.5-jdk17 AS build
WORKDIR /app
# Copy toàn bộ code vào trong container
COPY . .
# Chạy lệnh build của Gradle (thay vì mvn)
RUN ./gradlew bootJar --no-daemon

# Bước 2: Chạy ứng dụng với Java Runtime sạch
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy file jar đã build từ bước 1 sang (thư mục build/libs của Gradle)
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
