docker build -t sunitkulkarni/multi-client:latest -t sunitkulkarni/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sunitkulkarni/multi-server:latest -t sunitkulkarni/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sunitkulkarni/multi-worker:latest -t sunitkulkarni/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sunitkulkarni/multi-client:latest
docker push sunitkulkarni/multi-server:latest
docker push sunitkulkarni/multi-worker:latest

docker push sunitkulkarni/multi-client:latest:$SHA
docker push sunitkulkarni/multi-server:latest:$SHA
docker push sunitkulkarni/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sunitkulkarni/multi-server:$SHA
kubectl set image deployments/client-deployment client=sunitkulkarni/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sunitkulkarni/multi-worker:$SHA