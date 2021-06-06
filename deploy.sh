docker build -t aish2809/complexapp-client:latest -t aish2809/complexapp-client:$SHA -f ./client/Dockerfile ./client
docker build -t aish2809/complexapp-server:latest -t aish2809/complexapp-server:$SHA -f ./server/Dockerfile ./server
docker build -t aish2809/complexapp-worker:latest -t aish2809/complexapp-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aish2809/complexapp-client:latest
docker push aish2809/complexapp-server:latest
docker push aish2809/complexapp-worker:latest

docker push aish2809/complexapp-client:$SHA
docker push aish2809/complexapp-server:$SHA
docker push aish2809/complexapp-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aish2809/complexapp-server:$SHA
kubectl set image deployments/client-deployment client=aish2809/complexapp-client:$SHA
kubectl set image deployments/worker-deployment worker=aish2809/complexapp-worker:$SHA