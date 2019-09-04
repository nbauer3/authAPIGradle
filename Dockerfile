FROM gradle:jdk10 as builder
COPY --chown=gradle:gradle . /prj-auth-api
WORKDIR /prj-auth-api
RUN gradle bootJar

FROM openjdk:8-jdk-alpine
EXPOSE 8081
VOLUME /tmp
ARG LIBS=prj-auth-api/build/libs
COPY --from=builder ${LIBS}/ /prj-auth-api/lib
ENTRYPOINT ["java","-jar","./prj-auth-api/lib/spring-boot-jpa-0.0.1-SNAPSHOT.jar"]