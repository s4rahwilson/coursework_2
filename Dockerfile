FROM node:7-onbuild

LABEL maintainer "miiro@getintodevops.com"

HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://40.117.188.6:8080 || exit 1

EXPOSE 8080
