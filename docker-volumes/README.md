# docker-volumes

Ansible playbooks to backup and restore Docker volumes on the host.

## Usage

1. Create a new `config.yml` and `.gpg-pass` based on the dist examples.

### Backup

Run the backup playbook to encrypt and save volumes defined in `config.yml`:

```bash
ansible-playbook backup-volumes.yml
```

### Restore

Run the restore playbook to decrypt and restore volumes.

**Restore latest backup:**
```bash
ansible-playbook restore-volumes.yml
```

**Restore from a specific date:**
Provide the date string matching the backup filename (e.g., matching `volume-2023-10-27-10-00...`):

```bash
ansible-playbook restore-volumes.yml -e "restore_date=2023-10-27-10-00"
```
