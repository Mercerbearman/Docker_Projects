ARG BASE_IMAGE=centos

ARG BASE_TAG=5.11
ARG VAULT_REPO=https://vault.centos.org/5.11/os/x86_64/

#ARG BASE_TAG=6.10
#ARG VAULT_REPO=https://vault.centos.org/6.10/os/x86_64/

FROM ${BASE_IMAGE}:${BASE_TAG}

# Setup the vault repo.
COPY fileTemplates/CentOS-Base.repo /etc/yum.repos.d/
RUN rm /etc/yum.repos.d/libselinux.repo

# libselinux that comes on the base image is newer
# than the same package via the vault repo.  It causes
# the pacakages we are trying to install to fail because
# of an older dependency.  Downgrade for now.
RUN yum downgrade -y libselinux

# Core CLIP build dependencies
RUN yum update -y && \
  yum -y install \
  curl-devel-7.15.5-17.el5_9.x86_64 \
  dos2unix \
  expat-devel-1.95.8-11.el5_8.x86_64 \
  gcc-c++ imake \
  java-1.6.0-openjdk-devel \
  libstdc++-devel-4.1.2-55.el5.x86_64 \
  openssl-devel-0.9.8e-40.el5_11.x86_64 \ 
  pciutils  \
  pciutils-devel-3.1.7-5.el5.x86_64 \
  zlib-devel-1.2.3-7.el5.x86_64 && \
  yum clean all

# CHIEX dependencies
#RUN yum -y install qt-devel-3.3.6-26.el5.x86_64 \
#  qt-devel-docs-3.3.6-26.el5.x86_64 \
#  qt-designer \
#  openmotif-devel-2.3.1-7.4.el5.x86_64 \
#  python-devel-2.4.3-56.el5.x86_64

#RUN ln -s /usr/lib/qt-3.3 /opt/qt

# Setup files/setting required for building/running CLIP
COPY fileTemplates/cssabashrc.txt /root/.bashrc
COPY fileTemplates/limits.conf /etc/security/
COPY fileTemplates/sysctl.conf /etc/sysctl.conf
RUN dos2unix /root/.bashrc

CMD ["/bin/bash"]]