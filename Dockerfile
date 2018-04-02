FROM node:latest

RUN apt-get update &&\
    apt-get install -y rpm pacman bsdtar