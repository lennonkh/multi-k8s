docker build -t krykunov/multi-client:latest -t krykunov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t krykunov/multi-server:latest -t krykunov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t krykunov/multi-worker:latest -t krykunov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push krykunov/multi-client:latest
docker push krykunov/multi-server:latest
docker push krykunov/multi-worker:latest

docker push krykunov/multi-client:$SHA
docker push krykunov/multi-server:$SHA
docker push krykunov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=krykunov/multi-server:$SHA
kubectl set image deployments/client-deployment client=krykunov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=krykunov/multi-worker:$SHA