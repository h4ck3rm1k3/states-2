#!/usr/bin/env python
import errno
import os
import re
import shutil
import string
import sys
import tvdb_api
from tvdb_exceptions import tvdb_error, tvdb_shownotfound


CONFIG_FILE = '/etc/sabnzbd/scripts.conf'
EXTENSIONS = ['avi', 'm4v', 'mkv', 'mp4']
PATTERN = re.compile('^(.*)[\._]s(\d+)e(\d+)(.*)', re.I)


def get_config(cfgfile):
    config = {}
    with open(cfgfile) as fh:
        for line in fh:
            k, v = re.split('\s+=\s+', line, 1)
            config[k] = v.strip()
    return config


CONFIG = get_config(CONFIG_FILE)


def get_canonical_name(name):
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

    # look up TheTVDB for the show name
    canonical_name = get_tvdb_name(canonical_name)

    # replace trailing dots
    canonical_name = re.sub('\.+$', '', canonical_name)

    return canonical_name


def get_tvdb_name(show):
    tvdb = tvdb_api.Tvdb()
    try:
        return tvdb[show]['seriesname']
    except (tvdb_error, tvdb_shownotfound):
        return show


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
    # Loop through the files in ``job_dir``, trying to find one which
    # matches PATTERN. Also build a list of files and their sizes.
    #
    # If no files match PATTERN but we do find one or more files with
    # a suitable extension we assume the largest file is the one we
    # want. We take this file and use the ``job_dir`` as the base for
    # the new file name.
    match = None
    files_by_size = []
    for fn in os.listdir(job_dir):
        ext = fn.rsplit('.', 1)[-1]
        if ext not in EXTENSIONS:
            continue

        abs = os.path.abspath(os.path.join(job_dir, fn))
        files_by_size.append((fn, os.path.getsize(abs)))
        match = PATTERN.match(fn)
        if match:
            break

    files_by_size = sorted(files_by_size, key=lambda x: x[1])

    if not match:
        # no files at all? just exit
        if not files_by_size:
            print("No suitable files found")
            sys.exit()

        # found a potential match
        fn = files_by_size[0][0]
        match = PATTERN.match(os.path.basename(job_dir))
        if not match:
            print("No suitable files found")
            sys.exit()

    fn = os.path.join(job_dir, fn)
    dotted_name = string.capwords(match.group(1), '.').replace('_', '.')
    canonical_name = get_canonical_name(dotted_name)
    show_dir = os.path.join(CONFIG['tv_directory'], canonical_name)
    season_dir = os.path.join(show_dir, 'Season %s' % int(match.group(2)))

    vfile = "%s.s%se%s.%s" % (dotted_name, match.group(2), match.group(3), ext)
    final_name = os.path.join(season_dir, vfile)
    if os.path.isfile(final_name):
        print("File already exists: %s" % final_name)
        sys.exit(1)

    # create the full path to the new location, move the file over
    # and remove the old directory
    mkdirp(show_dir)
    mkdirp(season_dir)
    shutil.move(os.path.join(job_dir, fn), final_name)
    shutil.rmtree(job_dir)

    print("New file: %s (%s)" % (final_name, os.path.basename(fn)))

    # try to remove the empty category directories
    parent_dirname = os.path.dirname(os.path.abspath(job_dir))
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
