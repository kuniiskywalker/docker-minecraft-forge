# Base system is the LTS version of Ubuntu.
FROM   ubuntu:14.04 

# update package
RUN apt-get update -y

RUN apt-get install -y wget

# Download and install everything from the repos.
RUN    apt-get --yes update; apt-get --yes upgrade; apt-get --yes install software-properties-common
RUN    sudo apt-add-repository --yes ppa:webupd8team/java; apt-get --yes update
RUN    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
       echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
       apt-get --yes install curl oracle-java8-installer ; apt-get clean

RUN mkdir -m 777 /data

WORKDIR /data

RUN wget -O "/data/installer.jar" 'http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.0.2512/forge-1.12.2-14.23.0.2512-installer.jar'

RUN wget -O "/data/universal.jar" 'http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.0.2512/forge-1.12.2-14.23.0.2512-universal.jar'

RUN java -jar ./installer.jar nogui --installServer

RUN java -Xmx2048M -Xms1024M -jar universal.jar

RUN sed -e "s/eula=false/eula=true/g" eula.txt > aaa.txt
RUN mv aaa.txt eula.txt

ADD server.properties /data/

# mods

# 25565 is for minecraft
EXPOSE 25565

CMD ["java", "-Xmx2048M", "-Xms1024M", "-jar", "universal.jar"]
