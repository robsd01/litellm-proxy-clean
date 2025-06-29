FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install LiteLLM
RUN pip install 'litellm[proxy]' --no-cache-dir

# Copy configuration
COPY config.yaml /app/config.yaml

# Expose port
EXPOSE 4000

# Set environment variables
ENV LITELLM_CONFIG_PATH=/app/config.yaml
ENV PORT=4000
ENV HOST=0.0.0.0

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

# Use the direct litellm command (most reliable)
CMD litellm --config $LITELLM_CONFIG_PATH --host $HOST --port $PORT
