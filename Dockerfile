FROM alpine:3.14

RUN apk add py3-pip \
    && pip install --upgrade pip

WORKDIR /app
COPY . /app/
    
RUN pip install -r src/requirements.txt

EXPOSE 5000

CMD ["python3", "src/application.py"]

# New Relic agent
RUN pip install newrelic

# Non-secret defaults (can be overridden at runtime).
# NEW_RELIC_LICENSE_KEY is a secret: pass it at runtime with --env-file .env
ENV NEW_RELIC_APP_NAME="new_relic_docker_tutorial"
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG_LEVEL=info

ENTRYPOINT ["newrelic-admin", "run-program"]