# defining runtime environment
FROM python:3.10 
WORKDIR /app
COPY . /app
ENV PYTHONUNBUFFERED=1

# installing dependencies (sybil dependencies + flask for api endpoint)
RUN pip install .

# Launch flask endpoint
CMD ["python", "/app/server/server.py"]

