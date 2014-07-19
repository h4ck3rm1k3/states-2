#!/usr/bin/env python
from __future__ import print_function
import errno
import json
import os
import re
import shutil
import string
import sys

import requests


CONFIG_FILE = '/etc/sabnzbd/scripts.conf'
EXTENSIONS = ['avi', 'm4v', 'mkv', 'mp4']
SUB_EXTENSIONS = ['idx', 'sub', 'srt']
PATTERN = re.compile('^(.*)(\d{4})\.(.*)', re.I)
ENDPOINT = 'https://api.themoviedb.org/3/search/movie'


def get_config(cfgfile):
    config = {}
    with open(cfgfile) as fh:
        for line in fh:
            k, v = re.split('\s+=\s+', line, 1)
            config[k] = v.strip()
    return config


CONFIG = get_config(CONFIG_FILE)


def get_matching_files(dirname):
    # Loop through the files in ``job_dir``, trying to find one which
    # matches PATTERN. Also build a list of files and their sizes.
    #
    # If no files match PATTERN but we do find one or more files with
    # a suitable extension we assume the largest file is the one we
    # want. We take this file and use the ``job_dir`` as the base for
    # the new file name.
    files = {
        'match': (),
        'by_size': [],
        'subs': [],
    }
    for fn in os.listdir(dirname):
        ext = fn.rsplit('.', 1)[-1]
        if ext in SUB_EXTENSIONS:
            files['subs'].append(fn)

        if ext not in EXTENSIONS:
            continue

        abs = os.path.abspath(os.path.join(dirname, fn))
        files['by_size'].append((fn, os.path.getsize(abs)))
        match = PATTERN.match(fn)
        if match:
            files['match'] = (abs, match)
            break

    files['by_size'] = sorted(files['by_size'], key=lambda x: x[1])

    return files


def get_canonical_name(name, year):
    """
    Translates a dotted filename into the real name with spaces while
    preserving acronyms.
    """
    if not name.endswith('.'):
        name += '.'

    regex = '((?:[A-Z]\.)+)'
    acronyms = re.findall(regex, name)
    parts = re.split(regex, name)

    if not parts:
        return name

    canonical_name = []
    for part in parts:
        if part in acronyms:
            part = re.sub('\.$', '', part)
        else:
            part = part.replace('.', ' ')
        canonical_name.append(part.strip())
    canonical_name = ' '.join(canonical_name)

    # look up TMDb for the show name
    canonical_name = get_tmdb_name(canonical_name, year)

    # replace trailing dots
    canonical_name = re.sub('\.+$', '', canonical_name)

    return canonical_name


def get_tmdb_name(name, year):
    headers = {'Accept': 'application/json'}
    params = {
        'api_key': CONFIG['TMDB_API_KEY'],
        'query': name,
    }
    response = requests.get(ENDPOINT, params=params, headers=headers)
    results = json.loads(response.content.decode('utf-8'))['results']
    for r in results:
        if r['release_date'].split('-')[0] == year:
            return r['original_title']
    return name


def mkdirp(path, mode=0755):
    try:
        os.makedirs(path, mode=mode)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

    for r, _, _ in os.walk(path):
        os.chmod(os.path.join(path, r), mode)


def main(job_dir, nzb, clean, index_num, category, group, status):
    files = get_matching_files(job_dir)

    if files['match']:
        fn, match = files['match']
    else:
        # no files at all? just exit
        if not files['by_size']:
            print("No suitable files found")
            sys.exit()

        # found a potential match
        fn = files['by_size'][0][0]
        fn = os.path.join(job_dir, fn)
        match = PATTERN.match(os.path.basename(job_dir))
        if not match:
            print("No suitable files found")
            sys.exit()

    dotted_name, year = match.groups()[:2]
    canonical_name = get_canonical_name(dotted_name, year)
    dotted_name = canonical_name.replace(' ', '.')

    base_name = "%s.%s" % (dotted_name, year)
    for fn in [fn] + files['subs']:
        fn = os.path.basename(fn)
        ext = fn.rsplit('.', 1)[-1]
        final_name = os.path.join(CONFIG['movies_directory'], base_name + '.' + ext)
        if os.path.isfile(final_name):
            print("File already exists: %s" % final_name)
            sys.exit(1)

        # Move the files into place
        shutil.move(os.path.join(job_dir, fn), final_name)
        print("New file: %s (%s)" % (final_name, os.path.basename(fn)))

    # Remove the old directory
    shutil.rmtree(job_dir)

    # try to remove the empty category directories
    parent_dirname = os.path.dirname(job_dir)
    parent_basename = os.path.basename(parent_dirname)
    if parent_basename.lower() == category.lower():
        try:
            os.rmdir(parent_dirname)
            print("Removed empty directory: %s" % parent_dirname)
        except OSError:
            print("Skipped non-empty directory: %s" % parent_dirname)
            pass


if __name__ == '__main__':
    main(*sys.argv[1:])
