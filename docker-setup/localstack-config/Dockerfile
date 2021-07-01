FROM python:alpine

RUN apk --update add bash && \
    apk add dos2unix

WORKDIR /
COPY *.py ./
COPY requirements.txt .

RUN for i in /*.*; do dos2unix "$i"; done
RUN pip install -r requirements.txt
RUN chmod +x ./setup_aws.py

CMD [ "python", "setup_aws.py" ]