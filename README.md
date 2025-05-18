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
![Alt Text](https://drive.google.com/uc?export=view&id=1YH-UgdqM0LKE4p8YrBkkup0qXQBrTOO8)


1. **Agents** collect system logs and forward them to the Wazuh Manager.
2. **Manager** applies detection rules and forwards events to Logstash.
3. **Logstash** parses and enriches logs for Elasticsearch.
4. **Elasticsearch** stores and indexes events.
5. **Kibana** visualizes data; **AlertManager** orchestrates notifications.

---

## 🛠️ Prerequisites

* Docker & Docker Compose (v2.x)
* Git (v2.x)
* GitLab Runner (for CI/CD)
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
   docker logs wazuh-manager
   ```

5. **Access the UI**:

   * Kibana: [http://localhost:5601](http://localhost:5601)
   * Wazuh API: [http://localhost:55000](http://localhost:55000)

---

## ▶️ Running Threat Simulations

1. **SSH Brute‑Force (Hydra)**:

   ```bash
   cd simulations/ssh
   ./run_bruteforce.sh --target 192.168.100.10 --attempts 50
   ```

2. **Port Scanning (Nmap)**:

   ```bash
   cd simulations/portscan
   ./run_scan.sh --network 192.168.100.0/24
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

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`.
3. Commit your changes with clear messages.
4. Push to your branch: `git push origin feature/my-feature`.
5. Open a Pull Request against `main`.

Ensure your code passes CI checks and includes relevant tests or documentation.

---

## 🧑‍💻 Authors & Acknowledgments

* Ahmed Baha Eddine Alimi
* Egor Lazutkin
* Yusuf Abdughafforzoda
* Anvar Gelimov

Project Report & Demo Video: [Link to PDF report](https://example.com/report.pdf) | [Demo Video](https://example.com/demo)

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
