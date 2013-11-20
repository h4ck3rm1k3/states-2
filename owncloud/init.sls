owncloud:
  pkgrepo.managed:
    - name: deb http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_7.0/ /
    - repo: deb http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_7.0/ /
    - file: /etc/apt/sources.list.d/owncloud.list
    - keyid: BA684223
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: owncloud
