FROM swift:5.5 as build

WORKDIR /build
COPY Package.swift .
COPY Sources ./Sources
COPY Tests ./Tests

RUN swift build -c release

FROM swift:5.5-slim
WORKDIR /run

COPY --from=build /build/.build/release /run
ENTRYPOINT [ "/run/faas-fault-facilitator" ]