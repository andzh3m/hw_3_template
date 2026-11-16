#!/bin/sh
wait(){
    for i in $(seq 1 10); do
    curl -s http://127.0.0.1:8080/ > /dev/null && return 0
    sleep 0.5
  done
}
echo "running container"
docker compose up -d
wait

echo "incrementing counter"

curl -X POST http://127.0.0.1:8080/increment
curl -X POST http://127.0.0.1:8080/increment
curl -X POST http://127.0.0.1:8080/increment

echo "stopping container"

docker compose down

echo "running again"

docker compose up -d
wait

echo "reading counter"
curl http://127.0.0.1:8080/

echo "stopping conrainer"
docker compose down
