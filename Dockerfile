# dockerfile to build a nodejs image locally and serve wih nginx
FROM node:alpine as builder
LABEL MAINTAINER="carlosocb@gmail.com"

# working directory
WORKDIR /app

# copy source code
COPY . .

# install dependencies
RUN npm install

# build the app
RUN npm run build

# nginx image
FROM nginx:alpine

# copy build files to nginx
COPY --from=builder /app/build /usr/share/nginx/html

# expose port 80
EXPOSE 80

# start nginx
CMD ["nginx", "-g", "daemon off;"]

# docker build -t scratch-gui .
# docker run -d -p 5284:80 --name scratch-gui scratch-gui



