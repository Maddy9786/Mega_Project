FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY . .
RUN chmod +X mvnw && && ./mvnw clean package -DskipTests -B
RUN ls -la
EXPOSE 8080
CMD ["java", "-jar", "target/*.jar"]

