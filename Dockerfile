FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY form.html /usr/share/nginx/html/form.html
COPY investment-matrix.html /usr/share/nginx/html/investment-matrix.html
COPY investment-matrix/ /usr/share/nginx/html/investment-matrix/
COPY logo.png /usr/share/nginx/html/logo.png
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
