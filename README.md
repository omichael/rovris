**RO**ute**V**iews and **RIS**.ripe.net BGP data
using bgp [reader.](https://bgpstream.caida.org/docs/tools/bgpreader)


local testing with build via:
~~~~
docker build --no-cache -t rovris:0.00000001 .
docker run -it --rm --name my_rov -w "/tmp" rovris:0.00000001 \
  /usr/local/bin/bgpreader -p ris-live
docker ps -a
docker stop my_rov
docker run -it --rm --name my_rov -w "/tmp" rovris:0.00000001 \
  /usr/local/bin/bgpreader -p routeviews-stream
docker stop my_rov
~~~~

local testing with built image via:
~~~~
docker images | grep -i rovris
docker run -it --rm --name my_rov -w "/tmp" rovris:0.00000001 \
  /usr/local/bin/bgpreader -p ris-live
docker ps -a
docker stop my_rov
docker run -it --rm --name my_rov -w "/tmp" rovris:0.00000001 \
  /usr/local/bin/bgpreader -p routeviews-stream
docker stop my_rov
~~~~

[comment]: # (default branch)
