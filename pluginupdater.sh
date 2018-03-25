function pluginupdater_addmodified() {
	pluginupdater_setup
    cd /var/www/public/www
	php /home/vagrant/scripts/moodle-pluginupdater/addmodified.php
}

function pluginupdater_adduntracked() {
	pluginupdater_setup
    cd /var/www/public/www
	php /home/vagrant/scripts/moodle-pluginupdater/adduntracked.php
}

function pluginupdater_setup() {
	if [ ! -d /home/vagrant/scripts ]; then
		mkdir /home/vagrant/scripts
	fi

	if [ "$(ls -al /home/vagrant/scripts/moodle-pluginupdater)" ] && [ ! -f /home/vagrant/scripts/moodle-pluginupdater/adduntracked.php ] && [ ! -f /home/vagrant/scripts/moodle-pluginupdater/addmodified.php ] && [ ! -d /home/vagrant/scripts/moodle-pluginupdater/.git ]; then
		# Clear any phoneys. Shouldn't be any phoneys though.
		rm -rf /home/vagrant/scripts/moodle-pluginupdater
	fi

	if [ ! -d /home/vagrant/scripts/moodle-pluginupdater ]; then
		echo Installing pluginupdater from gitlab.
		git clone git@gitlab.learningworks.co.nz:troy/plugin-updater.git -b changes /home/vagrant/scripts/moodle-pluginupdater
	fi
}

# Add modified files to the moodle site repo.
alias addmodified="pluginupdater_addmodified"

# Add untracked files to the moodle site repo.
alias adduntracked="pluginupdater_adduntracked"
