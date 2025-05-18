# ThreatHound

**Internal Network Threat Detection & Monitoring**

ThreatHound is a scalable, containerized security monitoring solution for internal enterprise networks. It leverages the Wazuh Security Information and Event Management (SIEM) platform integrated with the ELK Stack (Elasticsearch, Logstash, Kibana) to collect logs in real time, detect internal and external threat vectors, and provide visual analytics and alerting.

---

## 🚀 Features

* **Real‑time Log Collection & Indexing**
  Deploys Wazuh agents and ELK Stack services via Docker Compose for consistent, portable environments.

* **Custom Threat Detection Rules**
  XML‑based Wazuh rules tailored for SSH brute‑force, port scans, anomalous logins, and other insider/outsider activities.

* **Threat Simulation**
  Automated Hydra scripts for SSH brute‑force and Nmap reconnaissance to validate alert pipelines and dashboards.

* **Visual Analytics & Alerts**
  Pre‑built Kibana dashboards for attack trends, geo‑IP visualizations, and customizable alerting rules.

* **DevSecOps Pipeline**
  GitLab CI/CD with Trivy scanning ensures container images meet security benchmarks before deployment.

* **Self‑Healing & Health Monitoring**
  Docker Compose healthchecks and restart policies maintain uptime under simulated attack loads.

---

## 📋 Architecture Overview
![Alt Text](https://drive.google.com/uc?export=view&id=1mq6WZqvZBjYuuAQdrtgZ3puTy7rlPKMo)


1. **Agents** collect system logs and forward them to the Wazuh Manager.
2. **Manager** applies detection rules and forwards events to Logstash.
3. **Logstash** parses and enriches logs for Elasticsearch.
4. **Elasticsearch** stores and indexes events.
5. **Kibana** visualizes data; **AlertManager** orchestrates notifications.

---

## 🛠️ Prerequisites

* Docker & Docker Compose (v2.x)
* Git (v2.x)
* (Optional) Hydra & Nmap for threat simulation scripts

---

## 🔧 Installation & Deployment

1. **Clone the repository**:

   ```bash
   git clone https://github.com/3llimi/ThreatHound.git
   cd ThreatHound
   ```

2. **Configure environment variables** (see `env.example`):

   ```bash
   cp env.example .env
   # Edit .env to set passwords, network ranges, etc.
   ```

3. **Start the stack**:

   ```bash
   docker-compose up -d
   ```

4. **Verify health**:

   ```bash
   docker ps
   ```

5. **Access the UI**:

   * Kibana: [http://localhost](http://localhost)

6. **Creating an agent**:
   * Now, you will see Kibana interface. Navigate to wazuh dashboard in kibana where informatoin about agents will be displayed. Create new agent with relevant configuration.
7. **Monitor your network**
---


## ▶️ Running Threat Simulations

1. **SSH Brute‑Force (Hydra)**:

   ```bash
   cd scripts
   chmod +x ssh_bruteforce.sh
   ./ssh_bruteforce.sh
   ```

2. **Port Scanning (Nmap)**:

   ```bash
   cd scripts
   chmod +x port_scan.sh
   ./port_scan.sh
   ```

Alerts and events appear in Kibana within \~25 seconds on average.

---

## 🗂️ Repository Structure

```
ThreatHound/
├── .github/
│   └── workflows/         # GitHub Actions CI definitions
├── elasticsearch/         # Elasticsearch index templates & config
├── kibana/                # Kibana dashboards & settings
├── logstash/              # Logstash pipeline configurations
├── nginx/                 # Nginx reverse‑proxy config
├── scripts/               # Attack simulation & helper scripts
├── wazuh/                 # Wazuh manager rules & decoders
├── .env                   # Environment variables (ignored by Git)
├── README.md              # Project overview and docs
└── docker-compose.yml     # Docker‑Compose service definitions

```

---

## 🧑‍💻 Authors & Acknowledgments

* Ahmed Baha Eddine Alimi
* Egor Lazutkin
* Yusuf Abdughafforzoda
* Anvar Gelimov

Demo Video & Report: [Link](https://drive.google.com/drive/folders/1g69810-Wned_i4K6u2U63hbUE4XmCykC?usp=sharing)

---

