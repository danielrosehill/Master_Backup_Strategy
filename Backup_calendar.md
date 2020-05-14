# Backup Calendar

The following recurrent task table can help to plan the seamless operation of backups — albeit through manual methods.


## Local backups (local file system -> *)

<hr>

### Onsite local backups (1-1)

#### Daily activities

**Local Timeshift backups (incremental)**: Daily, weekly monthly snapshots.

#### Quarterly activities


**Clonezilla live USB (main disk to backup local SSD)**: Quarterly

Table (fix formatting!)<br/>
| Backup  | Recurrence | Documentation |
| ---| --- |  | --- |
| Local Timeshift incremental backups  | Daily, weekly monthly  | Repository home  |
| Clonezilla main disk to local disk  | Every three months  |  [Repository home](https://github.com/danielrosehilljlm/Master_Backup_Strategy)  |

<hr>


### Offsite local backups (1-2)

**Cloudberry incremental full disk backup to B2:** Monthly <br/>
**Cloudberry or rclone Clonezilla image sync to B2:** Annually



Table (fix formatting!)<br/>
| Backup  | Recurrence | Documentation |
| ------------- | ------------- |  | ------------- |
| CloudBerry: incremental full disk backups to B2  | Monthly | [Repository home](https://github.com/danielrosehilljlm/Master_Backup_Strategy)  |
| CloudBerry: Clonezilla images to B2  | Annually  | [Repository home](https://github.com/danielrosehilljlm/Master_Backup_Strategy)  |


<hr>


## Cloud backups (cloud file systems -> *)

### All cloud to cloud backups (2-1)


### Weekly activities
**Google Drive copies to S3:** Weekly, via Multcloud(automated)<br/>
**pCloud copies to S3:** Weekly, via Multcloud (automated)

<hr>

### Quarterly activities
**pCloud archive snapshots to B2** Quarterly, retain 3 (manual)<br/>
**Misc cloud services to B2:** Quarterly (manual)

<hr>

### Annual activities

**Google Takeouts to B2:** Annualy, via EC2 + rclone (manual)



Table (fix formatting!)<br/>

| Backup  | Recurrence | Documentation |
| ------------- | ------------- |  | ------------- |
| Google Takeouts to B2  | Annually  | [Repository home](https://github.com/danielrosehilljlm/Master_Backup_Strategy/blob/master/documentation/Gsuite_Takeouts%20to%20B2.md)  |
| Google Drive weekly snapshots to Multcloud | Weekly | |
| pCloud snapshots to B2 | Quarterly | |
| Misc cloud services | Quarterly | |

