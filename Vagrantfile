# -*- mode: ruby -*-
# vi: set ft=ruby :

$installscript = <<SCRIPT

if [ ! -f "/var/www/.provisioned_defaultvhost" ]; then
    echo Copying default site config /var/www/000-default.conf to /etc/apache2/sites-available/000-default.conf
    cp /var/www/000-default.conf /etc/apache2/sites-available/
    touch /var/www/.provisioned_defaultvhost
fi

if [ ! -f "/var/www/.provisioned_phpini" ]; then
    echo Copying php.ini file with 1024M upload_max_filesize and post_max_size.
    cp /var/www/php.ini /etc/php/7.0/apache2/
    touch /var/www/.provisioned_phpini
fi

if [ ! -f "/var/www/.provisioned_mycnf" ]; then
    echo Copying .my.cnf file
    cp /var/www/.my.cnf /home/vagrant/
    touch /var/www/.provisioned_mycnf
fi

if [ ! -f "/var/www/.provisioned_pluginupdater" ]; then
    echo Adding plugin updater.

    cp /var/www/pluginupdater.sh /home/vagrant/
    cp /var/www/.bash_profile /home/vagrant/
    touch /var/www/.provisioned_pluginupdater
fi

if [ ! -d "/var/www/public/www" ]; then
    echo Making new www directory in /var/www/public/www
    mkdir /var/www/public/www
fi

if [ -z $(which htop) ]; then
    echo Installing htop
    apt-get install htop
fi

echo Setting timezone to Pacific/Auckland
timedatectl set-timezone Pacific/Auckland

echo Reloading Apache2
service apache2 reload
SCRIPT

Vagrant.configure("2") do |config|

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
    config.vm.box = "scotch/box-pro"
    config.vm.hostname = "scotchbox"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.10"
    config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]

    # Copy host gitconfig and ssh.
    config.vm.provision "file", source: "~/.gitconfig", destination: "~/.gitconfig"
    config.vm.provision "file", source: "~/.gitignore", destination: "~/.gitignore"
    config.vm.provision "file", source: "~/.ssh", destination: "~/.ssh"

    config.vm.provision "shell", inline: $installscript, privileged: true

    # Optional NFS. Make sure to remove other synced_folder line too
    #config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

end

