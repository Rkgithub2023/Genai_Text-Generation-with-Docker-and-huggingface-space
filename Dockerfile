FROM python:3

RUN apt-get update && apt-get install -y \
    cmake \
    pkg-config \
    build-essential \
    libprotobuf-dev \
    protobuf-compiler \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*  # Clean up the apt cache to reduce image size

# Upgrade pip to the latest version
RUN pip install --upgrade pip

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir -r /code/requirements.txt

RUN useradd -m user

USER user

ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

COPY --chown=user . $HOME/app

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]