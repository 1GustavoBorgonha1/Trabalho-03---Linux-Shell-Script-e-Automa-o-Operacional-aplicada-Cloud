FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
