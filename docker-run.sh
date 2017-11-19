if [ "$#" -eq 1 ] && [ $1 == "build" ]; then
    if [ -z $http_proxy ]; then
        docker build --build-arg http_proxy --build-arg https_proxy --rm -t carnd-path-planning .
    else
        docker build --rm -t carnd-path-planning .
    fi

fi
docker rm -f carnd-path-planning
if [ -z $http_proxy ]; then
    docker run -it --rm --name carnd-path-planning -v `pwd`:/project --entrypoint="/project/run.sh" -e http_proxy -e https_proxy -p 4567:4567 carnd-path-planning
else
    docker run -it --rm --name carnd-path-planning -v `pwd`:/project --entrypoint="/project/run.sh" -p 4567:4567 carnd-path-planning
fi