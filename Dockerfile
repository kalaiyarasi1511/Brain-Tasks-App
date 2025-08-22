# ----- build stage -----
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build   # produces dist/

# ----- runtime stage -----
FROM node:18-alpine
WORKDIR /app
RUN npm i -g serve@14
COPY --from=build /app/dist ./dist
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget -qO- http://127.0.0.1:3000/ || exit 1
CMD ["serve", "-s", "dist", "-l", "3000"]
