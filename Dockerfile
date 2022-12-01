FROM node:16-alpine
WORKDIR '/app'
COPY package.json ./
RUN npm install
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache

COPY . .
RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html
EXPOSE 80
