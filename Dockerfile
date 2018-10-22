FROM fedora

ARG RELEASE_VERSION=0.0.2
ARG RELEASE_HASH=7e870d3837eb1369e65a8ca1ea1ade8c11343a6f2fa01a747a5157265b5bb73f

ENV DOTNET_SDK_VERSION 2.1-2.1.402-1
ENV ASPNETCORE_PKG_VERSION 2.1.1
ENV IMAGE_DATE 2018-10-21
ENV IMAGE_NUM 002

RUN dnf update -y && dnf install wget -y && \
  set -ex \
  && cd /root && wget https://github.com/imdocker/dotnet-core4/releases/download/${RELEASE_VERSION}/nuget.tar.gz \
  && echo "${RELEASE_HASH}  nuget.tar.gz" | sha256sum -c \
  && tar -xf nuget.tar.gz && rm nuget.tar.gz \
    && dnf install -y https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm \
    && dnf install -y https://packages.microsoft.com/rhel/7/prod/dotnet-host-2.1.0-x64.rpm \
    && dnf install dotnet-sdk-2.1 wget libunwind nano mc compat-openssl10 icu iputils xz -y \
    && dnf clean all \
    && mkdir warmup \
    && cd warmup \
    && dotnet new \
    && cd .. \
    && rm -rf warmup \
    && rm -rf /tmp/NuGetScratch
