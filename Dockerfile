# Stage 1: Set up NGINX and serve the application
FROM nginx:alpine

# Remove the default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy a custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/

# Copy your static files to NGINX
COPY . /usr/share/nginx/html

# Expose the NGINX port (HTTP)
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
