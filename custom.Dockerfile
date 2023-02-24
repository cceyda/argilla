FROM continuumio/conda-ci-linux-64-python3.9:latest
USER root
# Exposing ports
EXPOSE 6900

# Copying argilla distribution files
COPY ./argilla /argilla
WORKDIR /argilla
RUN ls
RUN conda env update -n base --file ./environment_dev.yml
RUN ./scripts/build_distribution.sh

# Environment Variables
ENV USERS_DB=/config/.users.yml
ENV UVICORN_PORT=6900

# Copying script for starting argilla server
COPY ./scripts/start_argilla_server.sh /
WORKDIR /
RUN chmod +x /start_argilla_server.sh \
    && for wheel in /packages/*.whl; do pip install "$wheel"[server]; done

CMD /bin/bash /start_argilla_server.sh

