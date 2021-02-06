FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y --no-install-recommends \
      bc \
      build-essential \
      ffmpeg \
      libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY main.sh /root/
COPY user_requests_second.sh /root/
RUN set -x \
    && chmod +x /root/main.sh \
    && chmod +x /root/user_requests_second.sh 

ENTRYPOINT ["/root/main.sh"]
