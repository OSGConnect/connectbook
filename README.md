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

### Test Links Locally

```shell
# Build the site into /site directory
docker run --rm -v  ${PWD}:/docs ghcr.io/afritzler/mkdocs-material build

# Test the links
docker run --rm -it \
  -v $(pwd)/site:/src \
  klakegg/html-proofer:3.19.2 \
  --allow-hash-href --check-html --empty-alt-ignore --root-dir http://localhost:8000/connectbook/ --disable-external
```