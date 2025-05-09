FROM eclipse-temurin:21-alpine AS build  
WORKDIR /app
COPY . .
RUN ./gradlew clean build -x test 

FROM eclipse-temurin:21-alpine
COPY --from=build /app/build/libs/protospace-0.0.1-SNAPSHOT.jar protospace.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "protospace.jar", "--spring.profiles.active=prod", "--debug"]