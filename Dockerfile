# Pull base image
FROM python:3.8-slim

# PYTHONUNBUFFERED гарантирует, что наш вывод консоли выглядит знакомым 
# и не буферизируется Docker,что нам не нужно. 
# PYTHONDONTWRITEBYTECODE означает, что Python не будет пытаться 
# создавать файлы .pyc, которые мы также не желаем.
# uvicorn main:app --host 0.0.0.0 --port 5050
# sudo docker build -t project_builder .
# sudo docker run -d -p 5050:5050 -v /home/ubuntu/www/web-ar.studio/projects:/app/projects/ project_builder
# sudo docker run -it --rm -p 5050:5050 -v /home/ubuntu/www/web-ar.studio/projects:/app/projects/ project_builder
# sudo docker run -it --rm -p 5050:5050 -v /media/stevel/files/arProject/projects/test_volume:/app/projects/ project_builder
# sudo docker run -it --network=host --rm -p 5050:5050 -v /home/ubuntu/www/project.web-ar.studio:/app/projects/ project_builder


# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# RUN apt-get update \
#     && apt-get install -y \
#     libgl1-mesa-glx

COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["python", "src/app.py"]
# CMD uvicorn main:app --host 0.0.0.0 --port 5050