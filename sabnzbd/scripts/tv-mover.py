#!/usr/bin/env python
import errno
import os
import re
import shutil
import string
import sys


CONFIG_FILE = '/etc/sabnzbd/scripts.conf'
EXTENSIONS = ['avi', 'm4v', 'mkv', 'mp4']
PATTERN = re.compile('^(.*)\.s(\d+)e(\d+)(.*)', re.I)


def get_config(cfgfile):
    config = {}
    with open(cfgfile) as fh:
        for line in fh:
            k, v = re.split('\s+=\s+', line, 1)
            config[k] = v
    return config


def mkdirp(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise


def main(job_dir, nzb, clean, index_num, category, group, status):
    config = get_config(CONFIG_FILE)

    for fn in os.listdir(job_dir):
        ext = fn.rsplit('.', 1)[-1]
        if ext not in EXTENSIONS:
            continue

        match = PATTERN.match(fn)
        if not match:
            continue

        fn = os.path.join(job_dir, fn)
        dotted_name = string.capwords(match.group(1), '.')
        canonical_name = dotted_name.replace('.', ' ')
        show_dir = os.path.join(config['tv_directory'], canonical_name)
        season_dir = os.path.join(show_dir, 'Season %s' % int(match.group(2)))

        filename = "%s.s%se%s.%s" % (dotted_name, match.group(2), match.group(3), ext)
        final_name = os.path.join(season_dir, filename)
        if os.path.isfile(final_name):
            sys.stdout.write("File already exists: %s\n" % final_name)
            sys.exit(1)

        mkdirp(season_directory)
        shutil.move(fn, final_name)
        shutil.rmtree(job_dir)


if __name__ == '__main__':
    main(*sys.argv[1:])
