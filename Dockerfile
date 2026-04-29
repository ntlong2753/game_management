FROM tomcat:10.1-jdk17-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
# Nhớ kiểm tra tên file war trong build/libs nhé
COPY build/libs/game_management-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]