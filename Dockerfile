FROM python:3.10.14-slim

RUN apt-get update && apt-get install -y cron tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
WORKDIR /app/
COPY script.py /app/
RUN crontab /etc/cron.d/crontab
RUN mkdir -p /var/log/cron
CMD ["cron", "-f"]
