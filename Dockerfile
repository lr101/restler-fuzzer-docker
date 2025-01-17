FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as builder

RUN apk add --no-cache python3 py3-pip

COPY src ./src
COPY restler ./restler
COPY build-restler.py .

RUN python3 build-restler.py --dest_dir /build

RUN python3 -m compileall -b /build/engine

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine as target

RUN apk add --no-cache python3 py3-pip
RUN pip3 install requests applicationinsights

COPY --from=builder /build /RESTler

RUN mkdir /restler_bin

WORKDIR /restler_bin

COPY ./docker-entrypoint.sh /restler_bin/script.sh

RUN chmod 755 /restler_bin/script.sh

ENTRYPOINT ["/bin/sh", "/restler_bin/script.sh"]
