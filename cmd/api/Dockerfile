FROM golang

WORKDIR /app

COPY go.mod .

RUN go mod download

EXPOSE 4001

CMD ["go","run", "./cmd/api/..."]