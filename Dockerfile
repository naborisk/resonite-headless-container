FROM steamcmd/steamcmd:latest as builder
COPY .env ./.env
COPY download-headless.sh ./download-headless.sh
RUN chmod +x ./download-headless.sh
RUN ./download-headless.sh
RUN rm ./.env

FROM mcr.microsoft.com/dotnet/sdk:9.0
RUN	set -x && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install curl lib32gcc-s1 libopus-dev libopus0 opus-tools libc-dev && \
	rm -rf /var/lib/{apt,dpkg,cache}

# Copy the files from the builder
COPY --from=builder /Resonite/Headless /Headless
COPY --from=builder /root/.steam /root/.steam
COPY --from=builder /root/.local/share/Steam /root/.local/share/Steam

WORKDIR /Headless
STOPSIGNAL SIGINT
ENTRYPOINT [ "dotnet", "Resonite.dll" ]
