FROM node:10.16.0-alpine as build-step
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:1.17.1-alpine as prod-stage
COPY --from=build-step /app/dist/ang-docker-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
