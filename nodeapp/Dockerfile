FROM node:alpine

WORKDIR /app

COPY package*.json ./

# Install only production nodeJS dependencies in Docker Image
RUN npm install --only=production

COPY . .

EXPOSE 3000
CMD ["npm", "start"]
