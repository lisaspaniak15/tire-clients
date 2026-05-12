FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY form.html /usr/share/nginx/html/form.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
