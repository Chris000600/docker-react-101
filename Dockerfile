FROM node:16-alpine as builder

WORKDIR '/app'

COPY ./package.json .
RUN npm install 
COPY . .

# Results will be in /app/build
RUN npm run build

# Docker will automatically start the second step of the build when another FROM is used
# Use NGINX to reduce app size by only copying the build folder
FROM nginx

# Look at NGINX docs at dockerhub
COPY --from=builder /app/build /usr/share/nginx/html

# NGINX will automatically start without a command