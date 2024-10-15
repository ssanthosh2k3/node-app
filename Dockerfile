# Stage 1: Build the Node.js application
FROM node:14 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies (including dev dependencies for building)
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (if there's a build process)
# Example: RUN npm run build
# In case there's no build step, just skip this line

# Stage 2: Set up NGINX and serve the application
FROM nginx:alpine

# Remove the default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy a custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/

# Copy the production-ready application files from the build stage
COPY --from=builder /app /usr/share/nginx/html

# Expose the NGINX port
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
