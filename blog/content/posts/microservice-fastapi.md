---
title: "Microservice Fastapi"
date: 2023-05-03T12:25:32+03:00
draft: False
---


# Structure of project microservice on FastAPI 

When it comes to creating microservices using FastAPI, there is no single "best" project structure that will work for every project. However, there are some common patterns and practices that can help you organize your code in a way that makes it more scalable, maintainable, and easy to work with.

Here's an example project structure that you could use as a starting point for your own FastAPI microservices:

```
project/
├── app/
│   ├── __init__.py
│   ├── api/
│   │   ├── __init__.py
│   │   ├── endpoints/
│   │   │   ├── __init__.py
│   │   │   ├── example.py
│   │   │   └── ...
│   │   └── models/
│   │       ├── __init__.py
│   │       ├── example.py
│   │       └── ...
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py
│   │   ├── logging.py
│   │   ├── security.py
│   │   └── ...
│   ├── db/
│   │   ├── __init__.py
│   │   ├── repository.py
│   │   └── ...
│   ├── tests/
│   │   ├── __init__.py
│   │   └── ...
│   └── main.py
├── .env
├── .env.example
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
└── README.md
```

Here's a brief overview of what each directory and file contains:

- `app`: This is where you'll keep your application code. It contains subdirectories for your API endpoints (`api`), data models (`models`), core utilities (`core`), database access (`db`), and tests (`tests`). The `main.py` file contains the application startup code.

- `core`: This directory contains core application utilities, such as configuration settings, logging, and security helpers.

- `api`: This directory contains your API endpoints. It contains subdirectories for individual endpoints, which in turn contain the actual endpoint code.

- `db`: This directory contains database access code. You'll typically have a single file for each database table or collection.

- `tests`: This directory contains your application tests.

- `.env`: This file contains your application's environment variables.

- `Dockerfile` and `docker-compose.yml`: These files contain the Docker configuration for your application.

- `requirements.txt`: This file contains the Python dependencies for your application.

- `README.md`: This file contains information about your application, such as how to install and run it.

Of course, this is just one example of how you could structure your FastAPI microservices. You should adapt it to fit the specific needs of your project. However, this structure should give you a good starting point and help you organize your code in a scalable and maintainable way.


# Docker compose file

Sure, here's an example `docker-compose.yml` file for the project structure I suggested in the previous answer:

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    command: uvicorn app.main:app --host 0.0.0.0 --port 8000
    ports:
      - "8000:8000"
    env_file:
      - .env
    depends_on:
      - mongo

  mongo:
    image: mongo
    restart: always
    ports:
      - "27017:27017"
```

Here's what this `docker-compose.yml` file does:

- The `app` service builds the Docker image using the `Dockerfile` in the current directory. It then starts the FastAPI application using `uvicorn`, which listens on port `8000` and is exposed to the host machine through port `8000`.

- The `mongo` service uses the official `mongo` Docker image and exposes port `27017`, which is used by the FastAPI application to connect to the database.

- The `env_file` option specifies the path to the `.env` file, which contains the environment variables used by the FastAPI application.

- The `depends_on` option specifies that the `app` service depends on the `mongo` service. This ensures that the database is up and running before the application tries to connect to it.

You can run this `docker-compose.yml` file using the `docker-compose up` command in the directory containing the file.