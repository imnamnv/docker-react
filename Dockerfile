#set name of phase 1
FROM node:16-alpine as builder

WORKDIR /home/node/app
#--chown=node:node help we remove error permission
COPY --chown=node:node package.json . 
RUN npm install 
COPY --chown=node:node . .
RUN npm run build

FROM nginx

# Help elastic beantalk know port will map
# BUT now default elastic read docker-compose default
EXPOSE 80

#get name of phase 1
COPY --from=builder --chown=node:node /home/node/app/build /usr/share/nginx/html
