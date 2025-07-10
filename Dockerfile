FROM python:3.12-slim

USER root
RUN apt-get update && apt-get install -y \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    mariadb-client \
    openssh-server

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY start.sh .

RUN chmod +x start.sh

RUN ./start.sh

COPY configs/* /root/.jupyter/

COPY ./notebooks ./notebooks

COPY ./.ipython /root/.ipython

CMD ["jupyter", "lab", "--config=/root/.jupyter/jupyter_lab_config.py"]