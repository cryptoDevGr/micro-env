#FROM tiangolo/meinheld-gunicorn:python3.7
FROM python:3
MAINTAINER GEORGIOS FIOTAKIS <GEORGIOS.FIOTAKIS@AKKA.EU>

COPY ./wait_from_cloud_config.sh /wait_from_cloud_config.sh
RUN chmod +x /wait_from_cloud_config.sh

#Set up enviroment
RUN pip install --upgrade pip
# https://stackoverflow.com/questions/34819221/why-is-python-setup-py-saying-invalid-command-bdist-wheel-on-travis-ci
RUN pip install wheel
# RUN python setup.py bdist_wheel 
RUN pip install requests
RUN pip install py_eureka_client
RUN pip install flask
RUN pip install Flask-B3
RUN pip install Flask-Sleuth
#https://github.com/madzak/python-json-logger
RUN pip install json-logging
#Copy and run the app
COPY ./app /app

ENTRYPOINT ["/wait_from_cloud_config.sh", "python3", "/app/main.py" ]

