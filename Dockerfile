FROM node:20-alpine

WORKDIR /app

COPY package.json app.js ./

USER node

CMD ["npm", "start"]