docker build -t postgres_container -f Dockerfile.postgresql .
docker run -p 5432:5432 --name postgres_instance -e POSTGRES_PASSWORD=sql@sql -d postgres_container 

docker build -t python_app_container -f Dockerfile.python .
docker run -p 8888:3425 --name python_app_instance --link postgres_instance:postgres -d python_app_container
docker stop python_app_instance
docker rm python_app_instance
docker run -p 8888:3425 --name python_app_instance --link postgres_instance:postgres -d python_app_container
