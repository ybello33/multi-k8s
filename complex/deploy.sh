docker build -t ybello/multi-client:latest -t ybello/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ybello/multi-server:latest -t ybello/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ybello/multi-worker:latest -t ybello/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ybello/multi-client:latest
docker push ybello/multi-server:latest
docker push ybello/multi-worker:latest

docker push ybello/multi-client:$SHA
docker push ybello/multi-server:$SHA
docker push ybello/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ybello/multi-server:$SHA
kubectl set image deployments/client-deployment client=ybello/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ybello/multi-worker:$SHA
