# Use Node.js for serving the backend (app.js)
FROM node:alpine AS node-app

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

# Build the app (if needed)
# RUN npm run build

# Expose port 3000 for Node.js
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]

# Use NGINX to serve as reverse proxy
FROM nginx:alpine

# Remove default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/

# Copy static files to NGINX
COPY --from=node-app /usr/src/app/public /usr/share/nginx/html

# Expose NGINX port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
