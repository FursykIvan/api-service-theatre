FROM python:3.11-alpine3.21

ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8

WORKDIR /app

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/app" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    django-user

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN mkdir -p /app/media && \
    chown -R django-user /app/media && \
    chmod -R 755 /app/media && \
    chown -R django-user /app

USER django-user

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
