FROM registry.access.redhat.com/rhscl/python-36-rhel7:1-66

USER 0

RUN pip3 install flask

WORKDIR /app
COPY . /app

USER 1001
EXPOSE 8080
CMD ["python", "app.py"]
