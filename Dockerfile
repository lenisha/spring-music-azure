FROM gradle:4.10-jdk11-slim as builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
USER gradle              
RUN	gradle clean assemble

FROM openjdk:8-alpine
WORKDIR /home/
COPY --from=builder /home/gradle/build/libs/spring-music.jar /home/
ENTRYPOINT [ "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/home/spring-music.jar" ]
