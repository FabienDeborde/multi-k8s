docker build -t fabiendev/multi-client:latest -t fabiendev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fabiendev/multi-server:latest -t fabiendev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fabiendev/multi-worker:latest -t fabiendev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fabiendev/multi-client:latest
docker push fabiendev/multi-server:latest
docker push fabiendev/multi-worker:latest
docker push fabiendev/multi-client:$SHA
docker push fabiendev/multi-server:$SHA
docker push fabiendev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=fabiendev/multi-client:$SHA
kubectl set image deployments/server-deployment server=fabiendev/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=fabiendev/multi-worker:$SHA
