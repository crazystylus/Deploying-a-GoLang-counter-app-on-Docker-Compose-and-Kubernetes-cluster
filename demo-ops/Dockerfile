FROM golang:1.14

WORKDIR /go/src/app

COPY . .
RUN make build
RUN git clone https://github.com/vishnubob/wait-for-it.git wait-for-it
EXPOSE 8080

CMD ["/go/src/app/demo.bin"]