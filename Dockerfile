FROM ubuntu:xenial

LABEL MAINTAINER Ali Shanaakh <ashanaakh@heliostech.fr>

ENV HOME /dash
ENV DASH_VERSION 0.12.2.3

# Create dashd user
RUN groupadd -g 1000 dash \
    && useradd -u 1000 -g dash -s /bin/bash -m -d ${HOME} dash

RUN apt-get update && apt-get install -y wget curl

# Download dashd
RUN wget https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}/dashcore-${DASH_VERSION}-linux64.tar.gz
RUN tar -xvf dashcore-${DASH_VERSION}-linux64.tar.gz -C /tmp/ \
  && cp /tmp/dashcore*/bin/* /usr/local/bin \
  && rm -rf /tmp/dashcore*

# Prepare dash config
RUN mkdir ${HOME}/.dashcore
COPY config/dash.conf ${HOME}/.dashcore
RUN chown dash:dash -R ${HOME}

USER dash

WORKDIR /dash

EXPOSE 9998 19998

CMD ["dashd"]
