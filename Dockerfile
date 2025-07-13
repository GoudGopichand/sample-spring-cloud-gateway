FROM image-registry.openshift-image-registry.svc:5000/openshift/ubi8-openjdk-17-runtime:1.18

# Switch to root for installation
USER root

# Copy your source code into the container
COPY . /app
WORKDIR /app

# Install Maven (if not bundled)
RUN yum install -y maven && \
    mvn -B clean package

# Switch back to a safe UID
USER 185

# Run the app
CMD ["java", "-jar", "target/sample-spring-cloud-gateway.jar"]