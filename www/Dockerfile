FROM ubuntu:14.04
 
RUN mkdir -p /usr/src/app/client/tests
WORKDIR /usr/src/app/client

RUN apt-get update && apt-get install -y git npm nodejs && \ 
    apt-get install -y build-essential chrpath git-core libssl-dev libfontconfig1-dev

RUN npm install -g bower && \
    npm install -g grunt-cli && \
    npm install -g grunt

RUN apt-get install -y ruby-dev && \
    gem install --no-ri --no-rdoc compass && \
    ln -s /usr/bin/nodejs /usr/bin/node

COPY bower.json /usr/src/app/client/
COPY package.json /usr/src/app/client/
COPY Gruntfile.js /usr/src/app/client/

RUN bower install --allow-root && \
    npm install

COPY . /usr/src/app/client

CMD grunt dev

EXPOSE 9000
