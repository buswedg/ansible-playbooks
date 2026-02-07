# docker-volumes

Ansible playbooks to backup and restore Docker volumes on the host.

## Usage

1. Create a new `config.yml` and `.gpg-pass` based on the dist examples.

### Backup

Run the backup playbook to encrypt and save volumes defined in `config.yml`:

**Backup volumes for all services:**
```bash
ansible-playbook backup-volumes.yml
```

**Backup volumes for a specific service:**
```bash
ansible-playbook backup-volumes.yml -e "target_service=homepage"
```

### Restore

Run the restore playbook to decrypt and restore volumes.

**Restore latest backup volumes for all services:**
```bash
ansible-playbook restore-volumes.yml
```

**Restore latest backup volumes for a specific service:**
```bash
ansible-playbook restore-volumes.yml -e "target_service=homepage"
```

**Restore from a specific date for all services:**
Provide the date string matching the backup filename (e.g., matching `volume-2023-10-27-10-00...`):

```bash
ansible-playbook restore-volumes.yml -e "restore_date=2023-10-27-10-00"
```

**Restore from a specific date for a specific service:**
Provide the date string matching the backup filename (e.g., matching `volume-2023-10-27-10-00...`):

```bash
ansible-playbook restore-volumes.yml -e "target_service=homepage" -e "restore_date=2023-10-27-10-00"
```
