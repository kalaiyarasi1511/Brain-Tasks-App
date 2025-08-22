FROM node:18-alpine
WORKDIR /app
RUN npm i -g serve@14
COPY dist ./dist
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
