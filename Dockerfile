FROM golang:1.19-alpine3.16 AS build_base
WORKDIR /gocker-api
COPY go.mod go.sum ./
RUN go mod download && go mod verify

FROM build_base AS server_builder
COPY . .
RUN go build -o gocker-api ./cmd/gocker-api

FROM alpine:3.16
WORKDIR /root/
COPY --from=server_builder /gocker-api/gocker-api .
CMD [ "./gocker-api" ]
