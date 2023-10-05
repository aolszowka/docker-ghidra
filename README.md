# docker-ghidra
A container for Ghidra.

This builds on `lsiobase/kasmvnc` to provide web based access for this application.

## Building
`sudo docker build --tag docker-ghidra:latest .`

## Executing
`sudo docker run --rm -it -p 3000:3000 docker-ghidra:latest`

Then point your browser to `http://host:3000` to access the Web Based VNC Client.
