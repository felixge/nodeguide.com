nodeguide.com
=============

Local installation
------------------

### Linux - Debian/ Ubuntu

```bash
git clone git@github.com:felixge/nodeguide.com.git
cd nodeguide.com 
sudo apt install pandoc # if you don't yet have pandoc installed
make
```

### Viewing the Guide

You can run these commands to view the guide locally, temporarily.

|Technology|Command Line|
|---|---|
|**PHP**|`php -S localhost:8000`|
|**Python**|`python -m SimpleHTTPServer 8000`|
|**Python - twistd**|`twistd -n web -p 8080 --path .`|
|**Ruby**|`ruby -run -ehttpd . -p8080`|

Then visit: [http://localhost:8000](http://localhost:8000)