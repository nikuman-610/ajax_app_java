FROM eclipse-temurin:21-alpine AS build  
WORKDIR /app
COPY . .
RUN ./gradlew clean bootJar -x test && \
    ls -la build/libs/

FROM eclipse-temurin:21-alpine
COPY --from=build /app/build/libs/*.jar protospace.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "protospace.jar", "--spring.profiles.active=prod", "--debug"]