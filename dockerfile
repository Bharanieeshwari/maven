FROM nginx:latest
COPY /html /usr/share/nginx/html
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
EXPOSE 80