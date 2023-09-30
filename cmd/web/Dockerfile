FROM golang

WORKDIR /app

COPY go.mod .

RUN go mod download

EXPOSE 4000

CMD ["go","run", "./cmd/web/..."]