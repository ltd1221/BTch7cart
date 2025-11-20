FROM tomcat:10.1-jdk17

# Xoá ứng dụng mẫu của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR của bạn vào Tomcat
COPY ch07_cart.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
