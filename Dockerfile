FROM adoptopenjdk/openjdk11:alpine-slim
WORKDIR /app
# copy the packaged jar file into our docker image
COPY target/demo-0.0.1-SNAPSHOT.jar /app.jar
#COPY demo-0.0.1-SNAPSHOT.jar /app.jar
# set the startup command to execute the jar
CMD ["java", "-jar", "/app.jar"]