# Run Firefox in Docker Container
docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       icorrea/firefox:ubuntu-19.10