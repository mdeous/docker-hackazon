# docker-hackazon

Docker image for the [Rapid7's Hackazon](https://github.com/rapid7/hackazon) application.


## Usage

Image can be built and run using the provided `Makefile`:

* `make` or `make build` builds the container image
* `make run` starts the container

The application can then be accessed from a browser at [http://127.0.0.1/](http://127.0.0.1/).

Two user accounts are pre-configured:

|  Username  | Password |
| ---------- | -------- |
| test\_user | 123456   |
| admin      | password |

