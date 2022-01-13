ARG ALPINE=alpine:3.14
FROM ${ALPINE} AS verify
LABEL maintainer=lcm
ARG TAG
ARG LCMDIR=lhcp-lcm
ARG METALLB_VERSION="v0.9.6"
ARG METALLB_URL="https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/manifests/metallb.yaml"



# Proxies - not required when using public cloud image using circleci
ENV http_proxy http://web-proxy.houston.hpecorp.net:8080
ENV https_proxy http://web-proxy.houston.hpecorp.net:8080



# Setup Python and its dependencies
## RUN apk add --no-cache python3 python3-dev py3-pip gcc linux-headers musl-dev libffi-dev make
## RUN pip3 install --upgrade pip setuptools wheel \
## && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
## && if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi
# Installing Python Modules
## RUN pip3 install requests
## RUN pip3 install paramiko



WORKDIR ${LCMDIR}
RUN mkdir scripts
RUN mkdir manifests
ADD scripts/ ./scripts/
ADD manifests/ ./manifests/
RUN set -x \
&& apk --no-cache add \
curl \
wget \
jq
RUN set -x \
&& curl --output "manifests/metallb.yaml" --fail --location ${METALLB_URL} \
&& sed -i 's/Always/IfNotPresent/g' manifests/metallb.yaml



FROM ${ALPINE}
LABEL maintainer=lcm
ARG TAG
ARG LCMDIR=lhcp-lcm
COPY scripts/upgrade.sh /bin/upgrade.sh
COPY --from=verify ${LCMDIR}/scripts/ ${LCMDIR}/scripts/
COPY --from=verify ${LCMDIR}/manifests/ ${LCMDIR}/manifests/
ENTRYPOINT ["/bin/upgrade.sh"]
CMD ["upgrade"]