[title]: - "Switching between OASIS and local modules"

[TOC]

# Switching between module systems

Your local cluster may already have a modules system setup.  If this is 
the case, then you'll need to take some extra setup in order to access OASIS modules
in other to test your scripts.  The switching process is specific to each site,
so you should find your institution below and use the instructions there.


## Clemson Palmetto

These instructions indicate how to switch between the modules on the Palmetto
cluster at Clemson and OASIS.

First, run 
```
source /cvmfs/oasis.opensciencegrid.org/osg/modules/switch-modules/rcc/switch-modules.sh
```

### Switching to OASIS modules

In order to deactivate the local modules and activate the OASIS modules run
```
switch_modules oasis
```

### Switching to local modules
In order to deactivate the OASIS  modules and activate the local modules run 
```
switch_modules local
```

## UChicago RCC Midway

These instructions indicate how to switch between OASIS and local modules on the midway cluster 
at UChicago.  

First, run 
```
source /cvmfs/oasis.opensciencegrid.org/osg/modules/switch-modules/rcc/switch-modules.sh
```

### Switching to OASIS modules

In order to deactivate the local modules and activate the OASIS modules run
```
switch_modules oasis
```

### Switching to local modules
In order to deactivate the OASIS  modules and activate the local modules run 
```
switch_modules local
```

## Others
These instructions are for sites without modules installed

### Activating to OASIS modules
To activate OASIS modules run
```
source source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/$SHELL
```
