#first line of dockerfile is the image you are going to inherit from.
#go to hub.docker.com and search python to see the 3.7-alpine tag
FROM python:3.7-alpine
#specify env variable like below.
#its recommended to set Python to run on unbuffered.
ENV PYTHONUNBUFFERED 1

#install dependencies
# what this does is copy from directory adjacent to dockerfile and copy it on the docker image to /requirements.txt
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

#create empty directoy on docker image
RUN mkdir /app
#switch to that working directory
WORKDIR /app
# copy everything from local app folder into the dockerimage /app
COPY ./app /app

#the below is a user that simply runs the processes in our project. its not a admin user or a regular user.
RUN adduser -D user
#the below is the docker switching user to the user user. if we dont do this then the image will use root account. 
#if someone comprimises our app then they have root access to our root image and they can do messed up things
USER user