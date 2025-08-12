# build stage
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# production stage
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app/build ./build
# serve the static build using a simple server like serve
RUN npm i -g serve
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
