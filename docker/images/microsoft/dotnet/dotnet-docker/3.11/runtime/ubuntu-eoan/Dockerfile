FROM icorrea/ubuntu:19.10

ARG REPO=mcr.microsoft.com/dotnet/core/runtime

# Install ASP.NET Core
RUN aspnetcore_version=3.1.3 \
    && apt-get update \
    && apt-get install curl openssl -y \
    && curl -SL --output aspnetcore.tar.gz https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/$aspnetcore_version/aspnetcore-runtime-$aspnetcore_version-linux-x64.tar.gz \
    && aspnetcore_sha512='ced0b7c9faaf250fbee2c850e8941d47a17da06fa8e576d57063fa4bbc6c8435de6ab488b683d4a692cd622e24d9592f11608a1b358074167cf0b76024815611' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -C /usr/share/dotnet -oxzf aspnetcore.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1/g' /etc/ssl/openssl.cnf \
    && rm aspnetcore.tar.gz
