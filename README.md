# Overview
This repo contains a multi-stage Dockerfile that will build Hugo from source and copy the program to a minimal (scratch) Docker image.

## Build Instructions
Run the following command to build the latest version of Hugo.

```
./version build
```

You can change the Docker ID, Password and Hugo version by setting the following variables:

```
export DOCKER_ID=<yourid>
export VERSION=<hugoversiontag>
```

## Publish Image
The version script will publish the image to a Docker hub repository if you use the correct Docker ID, app name and password. Either set the password using `export PASSWORD=<yourpassword>` or create a file containing the password at: `~/.docker/password.txt`.

## Using the Image
The following example shows how to display the Hugo version:

```
docker run --rm -it tonymackay/hugo:v0.73.0 version
```

Assuming you are located in the root directory of a Hugo site, the following command will build your site:

```
docker run --rm -it -v $(pwd):/site tonymackay/hugo:v0.73.0 --environment=production --minify --cleanDestinationDir=true
```

The following command will run the built in Hugo server and allow you to access it from the host:

```
docker run --rm -it -v $(pwd):/site -p 1313:1313/tcp tonymackay/hugo:v0.73.0 server -D --watch --bind 0.0.0.0
```
