FROM python:3.11-slim

WORKDIR /app

# Install LiteLLM
RUN pip install 'litellm[proxy]' --no-cache-dir

# Copy configuration
COPY config.yaml /app/config.yaml

# Expose port
EXPOSE 4000

# Set environment variables for the proxy
ENV LITELLM_CONFIG_PATH=/app/config.yaml
ENV PORT=4000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

# Start the LiteLLM proxy server
CMD ["litellm", "--config", "/app/config.yaml", "--port", "4000", "--host", "0.0.0.0"]
