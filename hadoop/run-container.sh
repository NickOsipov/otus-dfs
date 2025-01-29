docker run \
    -it \
    --rm \
    --hostname=sandbox-hdp.hortonworks.com \
    --privileged=true \
    -p 2222:22 \
    -p 8080:8080 \
    -p 1080:1080 \
    -p 21000:21000 \
    -p 6080:6080 \
    -p 50070:50070 \
    -p 9995:9995 \
    -p 30800:30800 \
    -p 4200:4200 \
    -p 8088:8088 \
    -p 19888:19888 \
    -p 16010:16010 \
    -p 11000:11000 \
    -p 8744:8744 \
    -p 8886:8886 \
    -p 18081:18081 \
    -p 8443:8443 \
    -p 10000:10000 \
    --name hadoop \
    hortonworks/sandbox-hdp:3.0.1