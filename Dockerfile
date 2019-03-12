FROM fedora

ENV DOTNET_SDK_VERSION 2.2.2
ENV ASPNETCORE_PKG_VERSION 2.2.1
ENV IMAGE_DATE 2019-03-12
ENV IMAGE_NUM 008
ENV IMAGE_SDK 2.2-2.2.104-1.x86_64

#Use with dotnet-core4cache
RUN dnf update -y && dnf install wget -y && \
  set -ex \
    && dnf install -y https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm \
    && dnf install -y https://packages.microsoft.com/rhel/7/prod/dotnet-host-2.1.0-x64.rpm \
    && dnf install dotnet-sdk-2.2 wget libunwind nano mc compat-openssl10 icu iputils xz -y \
    && dnf clean all \
    && mkdir warmup \
    && cd warmup \
    && dotnet new \
    && cd .. \
    && rm -rf warmup \
    && rm -rf /tmp/NuGetScratch
