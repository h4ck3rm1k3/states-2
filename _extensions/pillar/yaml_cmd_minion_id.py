import logging
import yaml


log = logging.getLogger(__name__)


def ext_pillar(minion_id, pillar, command):
    '''
    Pass minion_id to a command and read the output as YAML
    '''
    try:
        return yaml.safe_load(__salt__['cmd.run']('{0} {1}'.format(command, minion_id)))
    except Exception:
        log.critical(
                'YAML data from {0} failed to parse'.format(command)
                )
        return {}
