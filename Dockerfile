# Use an official Node.js image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the React app
RUN npm run build

# Use NGINX to serve the build
FROM nginx:stable-alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
