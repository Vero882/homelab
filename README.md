# Homelab
This repository documents the setup and configuration of a personal Kubernetes staging cluster running within a <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/proxmox.png height=25 length=25> Proxmox Virtual Environment (VE). 

## Kubernetes Cluster Information

### **Cluster:** Staging
* **Kubernetes Distribution:** k3s
* **Version:** v1.32.3+k3s1
* **Container Runtime:** containerd
* **GitOps:** <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/flux-cd.png height=25 length=25> Flux CD

## Hardware
The homelab is built on the following hardware:

### Compute
* **san:** Minisforum MS-A1
    * CPU: AMD Ryzen 7 8700G
    * RAM: 96GB (2x 48GB) Crucial DDR5 5600MHz

* **spike:** Custom Build
    * CPU: Intel i7-4790K
    * RAM: 32GB (2x 16GB) 

* **faye (QDevice):** Dell Optiplex
    * CPU: Intel i5-4590S
    * RAM: 8GB

* **jet (Cold Backup/Retired):** Dell PowerEdge R630
    * CPU: x2 Intel Xeon E5-2683 v4
    * RAM: 672GB (21x 32GB) DDR3 2133MHz 

### Storage
* **Synology NAS:** DS920+
    * CPU: Intel Celeron J4125
    * RAM: 4GB
    * Storage:
        * 32TB (4x 8TB HDD) (SHR; 1 drive tolerance)

## Applications Deployed
Here are some of the applications currently running on the homelab:

### Kubernetes
#### Apps
| App | Description |
|-----|-------------|
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/audiobookshelf.png height=25 length=25> Audiobookshelf | Self-hosted Audiobook manager |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/linkding.png height=25 length=25> Linkding | Local bookmarks manager |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/n8n.png height=25 length=25> n8n | Self-hosted automation platform |
  <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/renovate.png height=25 length=25> Renovate | Automated dependency updates |
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
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/pi-hole.png height=25 length=25> PiHole | Network-wide ad blocking and local DNS. |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/portainer.png height=25 length=25> Portainer | Docker host container management |
| <img src=https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/twingate-light.png height=25 length=25> Twingate | Zero-trust remote network access |

## Future Improvements
* **Implement remote storage:** Implement remote storage using [Synology CSI](https://github.com/SynologyOpenSource/synology-csi)/[Synology CSI Talos](https://github.com/zebernst/synology-csi-talos) so pods are not tied to local volumes on nodes. [Talos Doc](https://www.talos.dev/v1.9/kubernetes-guides/configuration/synology-csi/)
* **Dashboard migration:** Migrate from [Heimdall](https://heimdall.site/) to [Homepage](https://gethomepage.dev/).
* **Kubernetes Distro:** Deploy baremetal production cluster with [Talos Linux](https://www.talos.dev/) for a full, cloud-native-like secured cluster. (Pending hardware purchase)
* **Infrastructure as Code:** Start managing as many items as possible with Terraform or Pulumi instead of traditional methods. 
