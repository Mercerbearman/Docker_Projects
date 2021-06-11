ARG BASE_IMAGE=centos

ARG BASE_TAG=5.11
ARG VAULT_REPO=https://vault.centos.org/5.11/os/x86_64/

#ARG BASE_TAG=6.10
#ARG VAULT_REPO=https://vault.centos.org/6.10/os/x86_64/

FROM ${BASE_IMAGE}:${BASE_TAG}

# Setup the vault repo.
COPY fileTemplates/CentOS-Base.repo /etc/yum.repos.d/
RUN rm /etc/yum.repos.d/libselinux.repo

# COPY fileTemplates/cssabashrc.txt /root/.bashrc
COPY fileTemplates/limits.conf /etc/security/
COPY fileTemplates/sysctl.conf /etc/sysctl.conf

CMD ["/bin/bash"]]