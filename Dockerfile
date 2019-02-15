FROM nginx

COPY . /

COPY nginx.conf /etc/nginx/

COPY . /usr/share/nginx/html/ 

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
