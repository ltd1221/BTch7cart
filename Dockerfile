FROM tomcat:10.1-jdk21

# Xoá app mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR của bạn
COPY ch07_cart.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
