FROM gradle:4.10-jdk11-slim as builder
COPY --chown=gradle:gradle . /home/gradle
WORKDIR /home/gradle
USER gradle              
RUN	gradle clean assemble

FROM openjdk:8-jdk-alpine
VOLUME /tmp
WORKDIR /home/
COPY --from=builder /home/gradle/build/libs/spring-music-1.0.0.jar /home/
EXPOSE 8080
ENTRYPOINT [ "java",  "-noverify","-XX:TieredStopAtLevel=1","-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/home/spring-music-1.0.0.jar" ]
