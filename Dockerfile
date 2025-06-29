FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip show litellm

COPY . .

ENTRYPOINT []

CMD ["litellm", "--proxy-server", "--port", "4000"]
