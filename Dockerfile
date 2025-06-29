FROM ghcr.io/berriai/litellm:main-latest

# Copy config file
COPY litellm_config.yaml /app/litellm_config.yaml

# The official image runs on port 4000 by default
EXPOSE 4000

# Use the official image's entry point with our config
CMD ["--config", "/app/litellm_config.yaml"]
