# Stage 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy only package.json and package-lock.json first
COPY package*.json ./

# Install dependencies inside container (fresh install)
RUN npm install

# Copy all source files (but not local node_modules)
COPY . .

# Build React app
RUN npm run build

# Stage 2: Serve with NGINX
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from build stage
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
