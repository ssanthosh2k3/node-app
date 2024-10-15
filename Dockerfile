# Stage 1: Build the application
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

# Stage 2: Create a production-ready image
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage (ignoring dev dependencies)
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Install only production dependencies (optional if everything was installed in builder stage)
# RUN npm install --production

# Expose the port the app runs on
EXPOSE 3000

# Start the Node.js application
CMD ["node", "app.js"]
