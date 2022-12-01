FROM node:16-alpine AS build
WORKDIR '/app'
COPY package.json ./
RUN npm install
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache

COPY . .
RUN npm run build
# production environment
FROM nginx:stable-alpine
EXPOSE 80
COPY --from=build /app/build /usr/share/nginx/html
# to make react-router work with nginx
# COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
