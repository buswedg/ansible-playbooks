# docker-backup-volumes

Ansible playbook which created backups of docker volumes on host.

## Usage

1. Create a new 'config.yml' and 'gpg.pass' based on the dist examples.

2. Run the below ansible-playbook command:

```bash
ansible-playbook backup-volumes.yml -e "/path/to/config.yml"
```