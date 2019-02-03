nodeguide.com
=============

Local installation
------------------

```bash
git clone git@github.com:felixge/nodeguide.com.git
cd nodeguide.com 
```

### Viewing the Guide

#### With Docker

If you don't know what Docker is, then it will be easiest for you to view the **Without Docker** instructions, below.

If you do not have a webserver (Apache/ Nginx) running, you will probably have port 80 available, in which case just run:

```bash
docker-compose up
```

If, however port 80 is already taken by a webserver (typical for a development environment), you will see an error like this: `Error starting userland proxy: listen tcp 0.0.0.0:80: listen: address already in use`.
In which case, you can use the "override" file to make it use a different port (e.g. 8080 if that is available):

```bash
cp docker-compose.override.yml.dist docker-compose.override.yml
docker-compose -f docker-compose.override.yml up
```

#### Without Docker - Debian/ Ubuntu

You can run these commands to view the guide locally, temporarily.

```bash
sudo apt install pandoc # if you don't yet have pandoc installed
make
```

|Technology|Command Line|
|---|---|
|**PHP**|`php -S localhost:8000`|
|**Python**|`python -m SimpleHTTPServer 8000`|
|**Python - twistd**|`twistd -n web -p 8080 --path .`|
|**Ruby**|`ruby -run -ehttpd . -p8080`|

Then visit: [http://localhost:8000](http://localhost:8000)

### See Also

- [Docker](https://www.docker.com/)
- [Pandoc](https://pandoc.org/installing.html)