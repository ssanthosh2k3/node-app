# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Remove the default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your HTML and CSS files to the default NGINX content directory
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
