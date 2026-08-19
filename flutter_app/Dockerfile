FROM cirrusci/flutter:stable
WORKDIR /app
COPY . /app
RUN flutter pub get
CMD ["flutter", "run", "-d", "web-server", "--web-hostname=0.0.0.0", "--web-port=8080"]
