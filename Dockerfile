FROM steamcmd/steamcmd:latest as builder
COPY .env ./.env
COPY download-headless.sh ./download-headless.sh
RUN chmod +x ./download-headless.sh
RUN ./download-headless.sh
RUN rm ./.env

FROM mono:6.12.0.182-slim
RUN apt update && apt install -y \
curl lib32gcc1 libc6-dev libopus-dev libopus0 opus-tools
COPY --from=builder /Resonite/Headless /Headless
WORKDIR /Headless
ENTRYPOINT [ "mono", "Resonite.exe" ]
