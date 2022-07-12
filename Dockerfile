#set name of phase 1
FROM node:16-alpine as builder

WORKDIR '/app'
#--chown=node:node help we remove error permission
COPY package.json . 
RUN npm install 
COPY . .
RUN npm run build

FROM nginx

# Help elastic beantalk know port will map
# BUT now default Elastic Beantalk read docker-compose default
EXPOSE 80

#get name of phase 1
COPY --from=builder /app/build /usr/share/nginx/html
