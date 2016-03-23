# Purpose

Devbox is a dockerized python development environment.

I was having trouble with DLL loading on my Mac, so decided to develop
in a Linux box, where things work as expected. This is the initial result
of that experimentation. There are lots of problems still in need of
addressing, but this should suffice for getting started.

# Usage

1. Clone this repo.
2. Add your stuff to **/src**
3. Run ./build
4. Run ./enter
5. Now you're in a Linux box with your source files. Have fun!

*This assumes that you have [Docker installed](https://docs.docker.com/engine/installation/).
After you install Docker, make sure that your shell is configured to find the
Docker host, so that commands like `docker build` and `docker run` will be able
to find the Docker daemon and pass the container for it to execute.*

# What do these files do?

- *Dockerfile* is the Docker **manifest**. It contains the recipe for
  building the Docker **image**, the thing that consequently gets executed
  to create a Docker **container** (this image/container distinction is analogous
  to the program/process distinction).
- *build* rebuilds the image. Run this when the source changes.
- *enter* dumps you into the Devbox. Must `./build` before entering.
- **src/** contains the application files (it's like **web** in dev).
- **shared/** is a (wait for it...) shared directory between your box
  and the container. It's "mounted" inside the container in **/shared**.

  - **shared/requirements.txt** This contains the state of Python
    packages. If a package is *not* on this list, Devbox won't have them
    installed, so make sure packages of interest are declared here.

    When you make new `pip install`s, make sure you freeze the list of
    installed packages and overwrite this file. I assume you can do this
    responsibly. If you screw this file up, please recover the original
    from the git history.

  - **shared/variables** This contains key environment variables. Right
    now it uselessly sets up virtual environment stuff, but can be used
    to declare application-specific settings, such as the place where
    you want your web server to dump its logs.

- **config/.bashrc** overwrites the bashrc in the container, so is used
    to source the above mentioned variables. You might ask why not just
    declare variables inside the .bashrc? This file might accidentally
    be made public, so I just want to make sure that variables, which
    may contain secret information, are given a little more special
    treatment.

# TODO

- Storing virtual environments in /shared creates a git problem. Not having
  virtual environments sucks.
- New packages can be installed, but the list must be frozen and stored in
  /shared/requirements.txt, since the image is immutable.
