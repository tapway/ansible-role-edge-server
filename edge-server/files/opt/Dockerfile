FROM netdata/netdata:v1.44.1

RUN apt-get update && apt-get install -y python3-pip nano \
    && pip install jetson-stats==4.2.7 --break-system-packages && \
    rm -rf /var/lib/apt/lists/*
