# The following docker file explains  
# building app using nodejs and copying files to nginx container and serving those files using nginx

FROM node:18-alpine AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
CMD ["nginx", "-g","daemon-off;"]


