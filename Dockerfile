# Define the base image with Node.js for ARM64 architecture
FROM node:17-alpine

# Create app directory in Docker
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies in Docker
RUN npm install

# Bundle app source inside Docker
COPY . .

# Bind the port that the app runs in
EXPOSE 8080

# Define the command to run the app
CMD [ "node", "src/index.js" ]
