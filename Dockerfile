FROM node:16 AS builder

WORKDIR /ShizukuIchi

RUN git clone --depth 1 https://github.com/ShizukuIchi/pdf-editor.git

WORKDIR /ShizukuIchi/pdf-editor

RUN yarn install
RUN yarn run build

FROM openresty/openresty:alpine

COPY --from=builder /ShizukuIchi/pdf-editor/public/ /usr/local/openresty/nginx/html

EXPOSE 80