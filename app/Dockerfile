FROM python:3.8-slim-buster

EXPOSE 80

WORKDIR /app

COPY . /app

RUN pip3 install -r requirements.txt

ENTRYPOINT ["streamlit", "run", "chatbot_frontend.py", "--server.port=80", "--server.address=0.0.0.0"]