FROM cypress/base:16.17.1

ENV ELECTRON_EXTRA_LAUNCH_ARGS=--disable-gpu

RUN mkdir -p /app/app
RUN mkdir -p /app/reports/videos
RUN mkdir -p /app/reports/screenshots

WORKDIR /app

COPY ./package.json /app

RUN npm install

COPY ./cypress /app/cypress
COPY ./example-tests /app/example-tests
COPY ./cypress.config.js /app
COPY ./.cypress-cucumber-preprocessorrc.json /app

RUN $(npm bin)/cypress verify

ENTRYPOINT ["npx", "cypress", "run"]
