#The OSG ConnectBook

Be sure to clone recursively!

git clone --recursive https://github.com/OSGConnect/connectbook.git

To update the submodules run

git submodule foreach git pull origin master

```shell
docker run --rm -it -p 8001:8001 -v ${PWD}:/docs squidfunk/mkdocs-material
```

ARM
```shell
docker run --rm -it -p 8000:8000 -v  ${PWD}:/docs ghcr.io/afritzler/mkdocs-material
```
