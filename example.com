server {
    listen       80  default_server;
    server_name  _; # some invalid name that won't match anything
    return       444;
}

server {
        listen   80;
        server_name example.com www.example.com;
        index index.php;
        

        location ~ /blog/?(.*)$ {
            root /var/www/example.com;
            try_files $uri $uri/ /blog/index.php?args;

            location ~ \.php$ {
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_index index.php;
                include fastcgi_params;
          }

        }


        location / {
                proxy_pass http://localhost:3001;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}
