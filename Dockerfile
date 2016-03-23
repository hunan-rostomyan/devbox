FROM lepinkainen/ubuntu-python-base:latest

# Utilities
RUN apt-get install -y tree
RUN apt-get install -y vim

# Create a directory to hold the source files.
RUN mkdir /code

# CD into it
WORKDIR /code

# Python dependencies
ADD shared/requirements.txt /code
RUN pip install --upgrade pip
RUN pip install -r /code/requirements.txt
RUN rm /code/requirements.txt

# Shell configuration
COPY config/.bashrc /root/

# Source files
ADD src /code

# Run the shell
CMD ["/bin/bash"]
