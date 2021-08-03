FROM golang:1.16

# Install imposm3
RUN apt-get purge -y --auto-remove \
    g++ gcc libc6-dev make git \
  && rm -rf /var/lib/apt/lists/*
 
RUN wget https://github.com/omniscale/imposm3/releases/download/v0.11.1/imposm-0.11.1-linux-x86-64.tar.gz
RUN tar -xvf imposm-0.11.1-linux-x86-64.tar.gz

ENV IMPORT_DATA_DIR=/import \
    IMPOSM_CACHE_DIR=/cache \
    MAPPING_YAML=./mapping.yml

WORKDIR ./
COPY . ./

RUN ln -s ./imposm-0.11.1-linux-x86-64/imposm3  ./imposm3
RUN ./imposm3 version

CMD ["./import-pbf.sh"]
