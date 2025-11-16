# Step 1: Use NGINX Base Image
FROM nginx:alpine

# Step 2: Install required tools
RUN apk update && apk add --no-cache curl unzip

# Step 3: Set Nexus info
ARG NEXUS_URL="http://13.50.5.238:8082/repository/maven-releases/com/javascript/app/react-build/1.0.0/react-build-1.0.0.zip"
ARG NEXUS_USER="admin"
ARG NEXUS_PASS="Munagoti@123"

# Step 4: Download artifact from Nexus
RUN echo "Downloading artifact from Nexus..." && \
    curl -u $NEXUS_USER:$NEXUS_PASS -o /tmp/react-build.zip "$NEXUS_URL"

# Step 5: Unzip the artifact
RUN unzip /tmp/react-build.zip -d /tmp/react-build

# Step 6: Copy build files to nginx HTML directory
RUN rm -rf /usr/share/nginx/html/* && \
    cp -r /tmp/react-build/build/* /usr/share/nginx/html/

# Step 7: Expose port 80
EXPOSE 80

# Step 8: Start NGINX
CMD ["nginx", "-g", "daemon off;"]

