# -*- mode: ruby -*-
# vi: set ft=ruby :

$installscript = <<SCRIPT
echo Copying default site config /var/www/000-default.conf => /etc/apache2/sites-available/000-default.conf
cp /var/www/000-default.conf /etc/apache2/sites-available/

echo default: Making new www directory in /var/www/public/www
mkdir /var/www/public/www

echo default: Making new directory for site data in /var/www/public/sitedata
mkdir /var/www/public/sitedata

echo default: Reloading Apache2
service apache2 reload
SCRIPT

Vagrant.configure("2") do |config|

    config.vm.box = "scotch/box-pro"
    config.vm.hostname = "scotchbox"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.10"
    config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
    config.vm.provision "shell", inline: $installscript, privileged: true

    # Optional NFS. Make sure to remove other synced_folder line too
    #config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

end