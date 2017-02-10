#!/bin/bash

echo "Please Enter Your WebSite Name :"
read WebSiteName

echo "Do You Want Remove Or Create (n for remove | y for create)"
read Action

if [ "$Action" == "y" ]; then

	echo "Please Enter Username :"
	read USERNAME

	echo "Do You Want Custom Dir (y|n)"
	read Answer

	if [ "$Answer" == 'y' ]; then
	    echo "Enter Dir : (Only Dir Without Project Folder)"
	    read DIR_ADDRESS

	    echo "Create Project..."
	    sudo mkdir -p $DIR_ADDRESS/$WebSiteName

	    echo "Change Owner..."
	    sudo chown -R $USERNAME:$USERNAME $DIR_ADDRESS/$WebSiteName

	    echo "Make Test Html File..."
	    html="<html>
		\n<head>
		    \n<title>Welcome to $WebSiteName!</title>
		\n</head>
		\n<body>
		    \n<h1>Success!  The $WebSiteName server block is working!</h1>
		\n</body>
	    \n</html>"

	    echo -e $html > $DIR_ADDRESS/$WebSiteName/index.html

	    echo "Make Link In Route"
	    sudo ln -s $DIR_ADDRESS/$WebSiteName /var/www

	    echo "Do You Want To Use Public Folder (y|n) :"
	    read Answer
	    if [ "$Answer" == 'y' ]; then
		config="##
		\n# Virtual Host configuration for example.com
		\n#
		\n# You can move that to a different file under sites-available/ and symlink that
		\n# to sites-enabled/ to enable it.
		\n#
		\nserver {
		\n	listen 80;
		\n	listen [::]:80;
		\n#
		\n	server_name $WebSiteName www.$WebSiteName;
		\n#
		\n	root /var/www/$WebSiteName/public;
		\n	index index.html index.htm index.php;
		\n#
		\n	location / {
		\n		try_files \$uri \$uri/ /index.php?_url=\$uri&\$args;
		\n	}
		\nlocation ~ \.php$ {
		\n	include snippets/fastcgi-php.conf;
		\n#
		\n#	# With php7.1-cgi alone:
		\n#	fastcgi_pass 127.0.0.1:9000;
		\n#	# With php7.1-fpm:
		    \nfastcgi_pass unix:/run/php/php7.1-fpm.sock;
		\n}
		\n}"
	    else
		config="##
		\n# Virtual Host configuration for example.com
		\n#
		\n# You can move that to a different file under sites-available/ and symlink that
		\n# to sites-enabled/ to enable it.
		\n#
		\nserver {
		\n	listen 80;
		\n	listen [::]:80;
		\n#
		\n	server_name $WebSiteName www.$WebSiteName;
		\n#
		\n	root /var/www/$WebSiteName;
		\n	index index.html index.htm index.php;
		\n#
		\n	location / {
		\n		try_files \$uri \$uri/ =404;
		\n	}
		\nlocation ~ \.php$ {
		\n	include snippets/fastcgi-php.conf;
		\n#
		\n#	# With php7.1-cgi alone:
		\n#	fastcgi_pass 127.0.0.1:9000;
		\n#	# With php7.1-fpm:
		    \nfastcgi_pass unix:/run/php/php7.1-fpm.sock;
		\n}
		\n}"
	    fi
	    

	    echo "Create Server Block File..."
	    echo -e $config | sudo tee --append /etc/nginx/sites-available/$WebSiteName

	    echo "Enable Your Server Blocks and Restart Nginx"
	    sudo ln -s /etc/nginx/sites-available/$WebSiteName /etc/nginx/sites-enabled/

	    sudo nginx -t

	    sudo systemctl restart nginx

	    echo "Config Hosts File In /etc/hosts..."
	    echo -e "127.0.0.1     $WebSiteName" | sudo tee --append /etc/hosts

	    echo "Done... And You Can Open Server With http://$WebSiteName"

	else
	    echo "Make Dir..."
	    sudo mkdir -p /var/www/$WebSiteName/html

	    echo "Change Owner..."
	    sudo chown -R $USERNAME:$USERNAME /var/www/$WebSiteName/html

	    echo "Make Test Html File..."
	    html="<html>
		\n<head>
		    \n<title>Welcome to $WebSiteName!</title>
		\n</head>
		\n<body>
		    \n<h1>Success!  The $WebSiteName server block is working!</h1>
		\n</body>
	    \n</html>"

	    echo -e $html > /var/www/$WebSiteName/html/index.html

	    echo "Do You Want To Use Phalconphp (y|n) :"
	    read Answer
	    if [ "$Answer" == 'y' ]; then
		config="##
		\n# Virtual Host configuration for example.com
		\n#
		\n# You can move that to a different file under sites-available/ and symlink that
		\n# to sites-enabled/ to enable it.
		\n#
		\nserver {
		\n	listen 80;
		\n	listen [::]:80;
		\n#
		\n	server_name $WebSiteName www.$WebSiteName;
		\n#
		\n	root /var/www/$WebSiteName/public;
		\n	index index.html index.htm index.php;
		\n#
		\n	location / {
		\n		try_files \$uri \$uri/ /index.php?_url=\$uri&\$args;
		\n	}
		\nlocation ~ \.php$ {
		\n	include snippets/fastcgi-php.conf;
		\n#
		\n#	# With php7.1-cgi alone:
		\n#	fastcgi_pass 127.0.0.1:9000;
		\n#	# With php7.1-fpm:
		    \nfastcgi_pass unix:/run/php/php7.1-fpm.sock;
		\n}
		\n}"
	    else
		config="##
		\n# Virtual Host configuration for example.com
		\n#
		\n# You can move that to a different file under sites-available/ and symlink that
		\n# to sites-enabled/ to enable it.
		\n#
		\nserver {
		\n	listen 80;
		\n	listen [::]:80;
		\n#
		\n	server_name $WebSiteName www.$WebSiteName;
		\n#
		\n	root /var/www/$WebSiteName;
		\n	index index.html index.htm index.php;
		\n#
		\n	location / {
		\n		try_files \$uri \$uri/ =404;
		\n	}
		\nlocation ~ \.php$ {
		\n	include snippets/fastcgi-php.conf;
		\n#
		\n#	# With php7.1-cgi alone:
		\n#	fastcgi_pass 127.0.0.1:9000;
		\n#	# With php7.1-fpm:
		    \nfastcgi_pass unix:/run/php/php7.1-fpm.sock;
		\n}
		\n}"
	    fi
	    
	    echo "Create Server Block File..."
	    echo -e $config | sudo tee --append /etc/nginx/sites-available/$WebSiteName

	    echo "Enable Your Server Blocks and Restart Nginx"
	    sudo ln -s /etc/nginx/sites-available/$WebSiteName /etc/nginx/sites-enabled/

	    sudo nginx -t

	    sudo systemctl restart nginx

	    echo "Config Hosts File In /etc/hosts..."
	    echo -e "127.0.0.1     $WebSiteName" | sudo tee --append /etc/hosts

	    echo "Done... And You Can Open Server With http://$WebSiteName"
	fi

else

	rm -rf /etc/nginx/sites-available/$WebSiteName
	rm -rf /etc/nginx/sites-enabled/$WebSiteName

	echo "Site Have Custom Dir (y,n)"
	read Answer

	if [ "$Answer" == "y" ]; then

	echo "Enter Dir : (Only Dir Without Project Folder)"
	read DIR_ADDRESS

	rm -rf $DIR_ADDRESS/$WebSiteName
	rm -rf /var/www/$WebSiteName
	
	elif [ "$Answer" == "n" ]; then

	rm -rf /var/www/$WebSiteName
	fi

fi


