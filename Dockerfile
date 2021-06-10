ARG BASE_IMAGE=centos

ARG BASE_TAG=5.11
ARG VAULT_REPO=https://vault.centos.org/5.11/os/x86_64/

#ARG BASE_TAG=6.10
#ARG VAULT_REPO=https://vault.centos.org/6.10/os/x86_64/

FROM ${BASE_IMAGE}:${BASE_TAG}

# Setup the vault repo.
COPY CentOS-Base.repo /etc/yum.repos.d/
RUN rm /etc/yum.repos.d/libselinux.repo

RUN yum install -y uname

CMD ["/bin/bash"]]