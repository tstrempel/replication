# syntax=docker/dockerfile:1
FROM fedora:34

RUN dnf install -y \
  git \
  openssl \
  openssl-devel \
  cargo \
  rust \
  make \
  gcc \
  python \
  python3 \
  python3-pip 
RUN git clone https://github.com/tstrempel/scaphandre && git clone https://github.com/tstrempel/sorting && git clone https://github.com/tstrempel/masterthesis-code && mkdir data
WORKDIR /scaphandre
RUN cargo build --release && cp target/release/scaphandre /usr/local/bin/
WORKDIR /sorting
RUN make && cp sorting sorting-O2 /usr/local/bin
WORKDIR /masterthesis-code/replication
RUN pip install -r ../requirements.txt && chmod u+x replication.sh
ENTRYPOINT ["/masterthesis-code/replication/replication.sh"]
