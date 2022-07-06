docker build -t connect2snehasis/multi-client:latest -t connect2snehasis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t connect2snehasis/multi-server:latest -t connect2snehasis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t connect2snehasis/multi-worker:latest -t connect2snehasis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push connect2snehasis/multi-client:latest
docker push connect2snehasis/multi-server:latest
docker push connect2snehasis/multi-worker:latest

docker push connect2snehasis/multi-client:$SHA
docker push connect2snehasis/multi-server:$SHA
docker push connect2snehasis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=connect2snehasis/multi-server:$SHA
kubectl set image deployments/client-deployment client=connect2snehasis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=connect2snehasis/multi-worker:$SHA