Personal [Salt](http://saltstack.org/) states. Developed for
Debian/Ubuntu.

    # Debian stable setup
    echo "deb http://debian.saltstack.com/debian wheezy-saltstack main" > /etc/apt/sources.list.d/salt.list
    wget -q -O- "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" | apt-key add -
    apt-get update
    apt-get install salt-minion
