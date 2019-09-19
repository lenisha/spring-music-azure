FROM gradle:4.10-jdk11-slim as builder
COPY --chown=gradle:gradle . /home/gradle
WORKDIR /home/gradle
USER gradle              
RUN	gradle clean assemble

FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY --from=builder /home/gradle/build/libs/spring-music-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-noverify","-XX:TieredStopAtLevel=1","-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/app.jar" ]
