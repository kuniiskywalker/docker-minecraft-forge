Docker for minecraft forge
====================

Build
--------------------

```
git clone git@github.com:kuniiskywalker/docker-minecraft-forge.git
cd docker-minecraft-forge
docker build -t kuniiskywalker/docker-minecraft-forge .
```

Run
--------------------

```
docker run -p 25565:25565 -v /volume:/data/world -d kuniiskywalker/docker-minecraft-forge
```
