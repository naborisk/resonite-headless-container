FROM steamcmd/steamcmd:latest as builder
COPY .env ./.env
COPY download-headless.sh ./download-headless.sh
RUN chmod +x ./download-headless.sh
RUN ./download-headless.sh
RUN rm ./.env

FROM mcr.microsoft.com/dotnet/sdk:8.0
RUN	set -x && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install curl lib32gcc-s1 libopus-dev libopus0 opus-tools libc-dev && \
	rm -rf /var/lib/{apt,dpkg,cache}

# install steam for steam api support
RUN echo "deb http://deb.debian.org/debian/ bookworm main contrib non-free" >> /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get update && \
  apt-get install -y steam-installer mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386

COPY --from=builder /Resonite/Headless /Headless
WORKDIR /Headless
STOPSIGNAL SIGINT
ENTRYPOINT [ "dotnet", "Resonite.dll" ]
