# Homelab
This repository documents the setup and configuration of a personal Kubernetes cluster running within a Proxmox Virtual Environment (VE). 

## Kubernetes Cluster Information
Cluster Details:

* **Kubernetes Distribution:** k3s
* **Version:** v1.32.3+k3s1
* **Nodes:**
    * **Control Plane Nodes:** 1x VM (3x planned), running Ubuntu Server. These nodes host the Kubernetes control plane components (API server, etcd, scheduler, controller manager).
    * **Worker Nodes:** 0x VMs (2x planned), running Ubuntu Server. These nodes run the containerized applications.
* **Container Runtime:** containerd
* **GitOps:** Flux CD

## Hardware
The homelab is built on the following hardware:

* **san (Primary):** Minisforum MS-A1
    * CPU: AMD Ryzen 7 8700G
    * RAM: 96GB (2x 48GB) Crucial DDR5 5600MHz

* **spike (Secondary):** Custom Build
    * CPU: Intel i7-4790K
    * RAM: 32GB (2x 16GB) 

* **jet (Cold Backup):** Dell PowerEdge R630
    * CPU: x2 Intel Xeon E5-2683 v4
    * RAM: 672GB (21x 32GB) DDR3 2133MHz 

* **Synology NAS:** DS920+
    * CPU: Intel Celeron J4125
    * RAM: 4GB
    * Storage:
        * 32TB (4x 8TB HDD) (SHR; 1 drive tolerance)

* **Proxmox Server:**
    * Proxmox VE 8.3.2

## Applications Deployed
Here are some of the applications currently running on the homelab:
*Note: Not all services have yet been migrated into Kubernetes and are still running on Ubuntu Docker hosts*

### Kubernetes
#### Apps
| App | Description |
|-----|-------------|
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/linkding.png height=25 length=25> Linkding | Local bookmarks manager |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/it-tools-light.png height=25 length=25> IT-Tools | Handy self-hosted dev tools |

#### Monitoring
| App | Description |
|-----|-------------|
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/grafana.png height=25 length=25> Prometheus & Grafana stack | Cluster-wide monitoring |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/uptime-kuma.png height=25 length=25> Uptime Kuma | Homelab monitoring |


#### Infrastructure
| App | Description |
|-----|-------------|
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/microsoft-azure.png height=25 length=25> External Secrets Operator | Syncing external secrets from Azure KeyVault to Kubernetes |

### Docker Hosts
| App | Description |
|-----|-------------|
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/heimdall-light.png height=25 length=25> Heimdall | Home dashboard |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/pi-hole.png height=25 length=25> PiHole | Network-wide ad blocking and DNS. |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/audiobookshelf.png height=25 length=25> Audiobookshelf | Self-hosted Audiobook manager |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/portainer.png height=25 length=25> Portainer | Docker host container management |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/twingate-light.png height=25 length=25> Twingate | Zero-trust remote network access |
| ... | Various additional serviecs |

## Future Improvements
* **Implement remote storage:** Implement remote storage using [Synology CSI](https://github.com/SynologyOpenSource/synology-csi)/[Synology CSI Talos](https://github.com/zebernst/synology-csi-talos) so pods are not tied to local volumes on nodes. [Talos Doc](https://www.talos.dev/v1.9/kubernetes-guides/configuration/synology-csi/)
* **Migration of apps & services:** Migrate additional services off of normal Docker hosts into Kubernetes.
* **Dashboard migration:** Migrate from [Heimdall](https://heimdall.site/) to [Homepage](https://gethomepage.dev/).
* **Kubernetes Distro:** Migrate from [k3s](https://k3s.io/) to [Talos Linux](https://www.talos.dev/) for a full, cloud-native-like secured cluster.
* **Infrastructure as Code:** Start managing as many items as possible with Terraform or Pulumi instead of traditional methods. 
