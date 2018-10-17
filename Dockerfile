FROM fedora

ARG RELEASE_VERSION=0.0.1
ARG RELEASE_HASH=5a126452dea8a852b997d9cabc5d1024cfbf68c22499e5bbb6b9f16a3b51e1e4

ENV DOTNET_SDK_VERSION 2.1-2.1.402-1
ENV ASPNETCORE_PKG_VERSION 2.1.1
ENV IMAGE_DATE 2018-10-17
ENV IMAGE_NUM 001

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
