ARG BASE_IMAGE=centos_base

ARG BASE_TAG=5.11

FROM ${BASE_IMAGE}:${BASE_TAG} AS build
# CHIEX dependencies
#RUN yum -y install qt-devel-3.3.6-26.el5.x86_64 \
#  qt-devel-docs-3.3.6-26.el5.x86_64 \
#  qt-designer \
#  openmotif-devel-2.3.1-7.4.el5.x86_64 \
#  python-devel-2.4.3-56.el5.x86_64

#RUN ln -s /usr/lib/qt-3.3 /opt/qt

# Setup directories that the CLIP build needs.
COPY tarballs tarballs

RUN cd /opt && \
  tar -xzvf /tarballs/rtidds41e-host-i86Linux.tar.gz && \
  tar -xzvf /tarballs/rtidds41e-i86Linux2.6gcc3.4.3.tar.gz && \
  tar -xzvf /tarballs/toolsdir_in_opt.tar.gz \
  && \
  ln -s /tarballs/ndds.4.1e ndds  \
  && \
  cd /usr/local \
  && \
  tar -xzvf /tarballs/gsl_fc5_install_in_usr_local.tar.gz && \
  tar -xvzf /tarballs/xerces.tar.gz \
  && \
  rm -rf /tarballs \
  && \
  cd && mkdir /vobs

# src will be mounted as a volume "-v command"

# Setup files/setting required for building/running CLIP
COPY fileTemplates/cssabashrc.txt /root/.bashrc
COPY fileTemplates/limits.conf /etc/security/
COPY fileTemplates/sysctl.conf /etc/sysctl.conf
RUN dos2unix /root/.bashrc

CMD ["/bin/bash"]]