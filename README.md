# FaaS Fault Facilitator


## I just want a quick demo

Clone this repo, `cd` into it, start Docker, run the following:

`docker run -it -v ${PWD}/configurations:/confs anyxo/fafafa /confs/minimal.yml`


## Running with Swift

Clone this repo, `cd fafafa`, run `swift run <config.yml>`


## Running with Docker

- create a local folder for your configuration input and output, e.g.
	- `mkdir myconfig`

- put your input configuration file into that folder, e.g.
	- `mv serverless.yml myconfig`
- run the Docker image, mapping your folder into the container, e.g.
	- `docker run -it -v ${PWD}/myconfig:/myconfig fafafa /myconfig/serverless.yml -o /myconfig/serverless_modified.yml  `

A few things to note here:
- `-it` is needed because this command requires an interactive shell
- `-v` needs absolute paths to work correctly (the example uses `${PWD}` for convenience
- `-o` and an output file can be omitted (then the result is printed to the console)

Additionally, please note that some functionality (currently wildcard pattern matching) is limited to macOS