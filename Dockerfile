FROM fedora

ARG RELEASE_VERSION=0.0.3
ARG RELEASE_HASH=b33a32a52ff7ce14f1096c4a5cbb8342c9f2b537678e836333a1cd5d86044f89

ENV DOTNET_SDK_VERSION 2.1.403
ENV ASPNETCORE_PKG_VERSION 2.1.1
ENV IMAGE_DATE 2018-11-09
ENV IMAGE_NUM 004

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
