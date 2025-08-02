# Stage 1: Build React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy only package files first
COPY package*.json ./

# Install fresh dependencies in container
RUN npm install

# Copy the rest of the source code
COPY . .

# Build React app
RUN npm run build

# Stage 2: Serve with NGINX
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
