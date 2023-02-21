FROM node:18-alpine

RUN apk add --no-cache ca-certificates \
    jq curl bash nodejs aws-cli && \
    # Install helm version 3:
    curl -L https://get.helm.sh/helm-v3.11.1-linux-amd64.tar.gz | tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

WORKDIR /action

COPY package.json package-lock.json ./
RUN npm install

COPY index.js ./
COPY ./charts ./charts

ENTRYPOINT ["node", "index.js"]
