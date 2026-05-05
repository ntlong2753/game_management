#FROM tomcat:10.1-jdk17-openjdk-slim
#RUN rm -rf /usr/local/tomcat/webapps/*
## Nhớ kiểm tra tên file war trong build/libs nhé
#COPY build/libs/game_management-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
#EXPOSE 8080
#CMD ["catalina.sh", "run"]

# Giai đoạn 1: Build file WAR bằng Gradle
FROM gradle:7.6-jdk11-alpine AS build
WORKDIR /app

# Copy các file cấu hình Gradle trước để tận dụng cache của Docker
COPY build.gradle settings.gradle ./
COPY src ./src

# Thực hiện build file WAR
# Lệnh này sẽ tạo ra file .war trong thư mục build/libs/
RUN gradle clean war --no-daemon

# Giai đoạn 2: Chạy bằng Tomcat
FROM tomcat:10.1-jdk17-openjdk-slim
WORKDIR /usr/local/tomcat/webapps/

# Xóa các app mặc định để tránh xung đột
RUN rm -rf ROOT*

# Copy file war từ giai đoạn build sang
# Lưu ý: Kiểm tra tên file war trong build/libs/ của bạn, thường là [tên-dự-án].war
COPY --from=build /app/build/libs/*.war ./ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]