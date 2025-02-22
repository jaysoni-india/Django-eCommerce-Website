FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_HOME="/opt/poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"
ENV POETRY_VIRTUALENVS_CREATE=false

WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        libgobject \
        python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python -


COPY pyproject.toml poetry.lock ./
RUN poetry install --no-interaction --no-ansi --no-root

RUN rm /app/*
