# DIGS-tool-Dockerfile
Dockerfile for DIGS-tool

# How to use?

1. Install Docker on your system.
2. Build the image (on xenial) `sudo docker build -t digs:1.0 .`
3. Run the image (on xenial) `sudo docker run -it digs:0.1 bash`
4. Run `./start.sh` to start mysql server
5. Run example: `./DIGS-tool.pl -m=2 -i=example_ctl.txt`
6. Run `Rscript result.R` to save the results into a file.

It should work. Now you can/should download your sequences (host, virus) and put them to the right folder according the DIGS description.
