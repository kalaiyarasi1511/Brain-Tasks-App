# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage - simple express server to serve build on port 3000
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production
# Install a small server
RUN npm i -g serve
# Copy build
COPY --from=builder /app/build ./build
# Use "serve" to host static build on port 3000
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
