#DOCKER CLAMAV ZIMBRA
## Introduction

I've written this to build ClamAV for Zimbra in order to solve the problem described
here(https://blog.zimbra.com/2016/10/clamav-v0-97-included-zcs-8-0-6-tags-messages-unchecked/), because I don't trust binaries coming from other people and Zimbra guys didn't sign the packages provided in the article.

## Usage
### Cloning this repository

```
$ git clone https://github.com/patriziotufarolo/docker-clamav-zimbra
$ cd docker-clamav-zimbra
$ docker build -t buildclamavzimbra .
$ docker run -v /opt/zimbra:/opt/zimbra buildclamavzimbra
```

### Directly building the repository
```
$ docker build -t buildclamavzimbra https://github.com/patriziotufarolo/docker-clamav-zimbra.git
$ docker run -v [...] #as above
```

### From the Docker hub
```
$ docker pull patriziotufarolo/clamavzimbrabuild
$ docker run -v /opt/zimbra:/opt/zimbra clamavzimbrabuild
```

### Then
At the end of the execution you will find the clamav folder in /opt/zimbra.
All you have to do is now to:

- Stop Zimbra services with
```
# /opt/zimbra/bin/zmcontrol stop
```
- Put config files in the right place
```
# cp /opt/zimbra/clamav/etc/* /opt/zimbra/clamav-YOURVERSION/etc/
```
and optionally change their ownership to match `zimbra:zimbra`.

- Unlink ` /opt/zimbra/clamav ` and link it back to the new version

```
# unlink /opt/zimbra/clamav
# ln -s /opt/zimbra/clamav-YOURVERSION /opt/zimbra/clamav
```

- Do not forget to eventually fix your configs and populate your database:

```
# /opt/zimbra/clamav/bin/freshclam
```

- Run Zimbra again 

```
/opt/zimbra/bin/zmcontrol start
```

## Final note
The selected ClamAV version for this Dockerfile is 0.99.2.
You can customize it, if you want, by passing `-e version=whateveryouwant` to `docker run` when launching the container.

