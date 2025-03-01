version: '3.8'

services:
  db:
    image: postgres:15
    container_name: taski_db
    restart: always
    environment:
      POSTGRES_DB: taski_db
      POSTGRES_USER: taski_user
      POSTGRES_PASSWORD: taski_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  web:
    build: ./backend
    container_name: taski_backend
    depends_on:
      - db
    environment:
      DATABASE_URL: postgresql://taski_user:taski_password@db:5432/taski_db
    ports:
      - "8000:8000"
    volumes:
      - static_volume:/app/static
    command: /app/entrypoint.sh

volumes:
  postgres_data:
  static_volume:
