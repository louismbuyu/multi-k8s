docker build -t louismbuyu17/multi-client:latest -t louismbuyu17/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t louismbuyu17/multi-server:latest -t louismbuyu17/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t louismbuyu17/multi-worker:latest -t louismbuyu17/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push louismbuyu17/multi-client:latest
docker push louismbuyu17/multi-server:latest
docker push louismbuyu17/multi-worker:latest

docker push louismbuyu17/multi-client:$SHA
docker push louismbuyu17/multi-server:$SHA
docker push louismbuyu17/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=louismbuyu17/multi-server:$SHA
kubectl set image deployments/client-deployment client=louismbuyu17/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=louismbuyu17/multi-worker:$SHA
