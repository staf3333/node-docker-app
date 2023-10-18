# define what base image we want to build from!
FROM node:18

# create directory to hold the application code inside the image, will be working directory for application
# any run, cmd, add, copy, or entrypoint command will be executed in specified working directory
WORKDIR /usr/src/app

# install app dependencies using npm
# use a wildcard(wtf is that? Guess: anything that matches criteria up to that point and anything that comes after) to make sure both package.json AND package-lock.json are copied!
COPY package*.json ./
RUN npm install

# hmmm instead of copying entire working directory, only copying the package.json file
# this allows us to take advantage of cached Docker layers (have no idea how this works LOL)
# if we didn't do this, we'd be building our modules everytime we make a change to a file in our container

# By seperating these two steps (/\, \/), this means result of npm install (i.e. STATE of container after executing command)
# can be cached by docker and thus don't have to be executed every time a part of the application code changes. Makes deploys faster!

# Bundle app source code... what does this mean?
# Distinction between application and its dependencies: Running npm install after copying package.json only installs dependcies of app (creates node_modules folder)
# BUT, actual application code isn't inside the container yet! That's what COPY . . does
COPY . .

# App binds to port 8080 so use expose instruction to have it mapped by the docker daemon
EXPOSE 8080

# LASTLY, define command that runs application!
CMD [ "node", "index.js" ]