FROM  centos/httpd:latest

# Update & upgrades
RUN yum update -y && yum upgrade -y && yum clean all

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum install yum-utils && \
    yum-config-manager --enable remi-php72 && \
    yum update -y && \
    yum install -y \
    php72-php.x86_64 \
    php72-php-bcmath.x86_64 \
    php72-php-cli.x86_64 \
    php72-php-common.x86_64 \
    php72-php-devel.x86_64 \
    php72-php-gd.x86_64 \
    php72-php-intl.x86_64 \
    php72-php-json.x86_64 \
    php72-php-pecl-mongodb.x86_64 \
    php72-php-mbstring.x86_64 \
    php72-php-mcrypt.x86_64 \
    php72-php-mysqlnd.x86_64 \
    php72-php-ldap.x86_64 \
    php72-php-pdo.x86_64 \
    php72-php-pear.noarch \
    php72-php-gmp.noarch \
    php72-php-xml.x86_64 \
    php72-php-ast.x86_64 \
    php72-php-opcache.x86_64 \
    php72-php-pecl-zip.x86_64 \
    php72-php-pecl-memcached.x86_64 && \
    ln -s /usr/bin/php72 /usr/bin/php && \
    ln -s /etc/opt/remi/php72/php.ini /etc/php.ini && \
    ln -s /etc/opt/remi/php72/php.d /etc/php.d && \
    ln -s /etc/opt/remi/php72/pear.conf /etc/pear.conf && \
    ln -s /etc/opt/remi/php72/pear /etc/pear

RUN yum install -y httpd-devel.x86_64 nano wget memcached git unzip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 apache && ln -sf /dev/stdout /var/log/httpd/access_log && ln -sf /dev/stderr /var/log/httpd/error_log

COPY ./httpd.conf /etc/httpd/conf/httpd.conf