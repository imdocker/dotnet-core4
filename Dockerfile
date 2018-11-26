FROM fedora

ENV DOTNET_SDK_VERSION 2.1.500
ENV ASPNETCORE_PKG_VERSION 2.1.6
ENV IMAGE_DATE 2018-11-26
ENV IMAGE_NUM 005

#Use with dotnet-core4cache
RUN dnf update -y && dnf install wget -y && \
  set -ex \
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
