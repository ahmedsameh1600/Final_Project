# Use an official Tomcat image as the base
FROM tomcat:9.0

# Copy the built WAR file into the Tomcat webapps directory
COPY target/*.war /usr/local/tomcat/webapps/jpetstore.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
