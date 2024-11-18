FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Expose the port of the app on the container
EXPOSE 3000

CMD ["node", "app.js"]
