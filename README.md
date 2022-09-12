[![Validate static MkDocs pages](https://github.com/osg-htc/osg-portal-documentation/actions/workflows/validate-mkdocs.yml/badge.svg)](https://github.com/osg-htc/osg-portal-documentation/actions/workflows/validate-mkdocs.yml)

# Mkdocs Static Website 

If you are here to edit something you are likely in the wrong place. 

To edit the OSG Portal look here -> https://github.com/osg-htc/osg-portal

To edit User Documentation look here -> https://github.com/osg-htc/user-documentation

## For the Minority

This repository hosts the code for building the static Mkdocs website that is hosted at portal.osg-htc.org/documentation. 

All new commits to master are built into a static site found on the ```static``` branch, which is then pulled into the osg-portal.

Changes you should be making here include:
- HTML Templates

**There is 0 reason to touch the ```./user-documentation``` folder from this repo** 

If you are looking to change the following look in [here](https://github.com/osg-htc/user-documentation):
- CSS
- Documentation
- Website Layout

### Development

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
  -v $(pwd)/documentation:/src \
  klakegg/html-proofer:3.19.2 \
  --allow-hash-href --check-html --empty-alt-ignore --disable-external
```
