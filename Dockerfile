FROM arm64v8/ubuntu

RUN apt-get update && apt-get install -y \
    wget 

RUN wget https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-aarch64-static && \
    chmod +x airupnp-aarch64-static

# setconfig.sh and setoptions.sh dynamically create the config.xml and options.txt files,
ADD ./setconfig.sh setconfig.sh
ADD ./setoptions.sh setoptions.sh
RUN chmod +x setconfig.sh setoptions.sh


CMD ./setconfig.sh > ~/config.xml ; \
    ./setoptions.sh > ~/options.txt ; \
    ./airupnp-aarch64-static -Z -x ~/config.xml $(cat ~/options.txt)
