# TORCH

## 🔍 Overview

TORCH is a tool designed for data extraction based on structured cohort definitions (CRTDL). It is part of the [Feasibility Triangle](https://github.com/medizininformatik-initiative/feasibility-triangle) ecosystem, enabling consent-aware extraction of FHIR data.

For full technical documentation, visit the [official TORCH repository](https://github.com/medizininformatik-initiative/torch).

---

## ⚙️ Setting Up TORCH

TORCH is configured via a `.env` file. This file is prepared automatically when running:

```bash
./feasibility-triangle/initialise-triangle-env-files.sh
```

### 🔧 Starting TORCH

You can start TORCH in two ways:

1. **As part of the full Triangle setup**  
   Follow the setup instructions in the Triangle's `README.md`.

2. **Independently using Docker Compose**  
   From this directory, run:
   ```bash
   docker compose up -d
   ```

> ⚠️ **Note:**  
> Ensure that the URLs configured in your `.env` file (e.g., FHIR server, FLARE, output file server) are reachable from within the TORCH container. TORCH communicates directly with these endpoints during execution.

### 📂 Data Sharing

TORCH exports extracted data to a mounted volume which is served via a webserver. By default, an `nginx` webserver is included in this setup to expose the files.

- You can **customize** or **replace** the webserver in `docker-compose.yml`.
- You may also mount the volume directly to your host for easier access by setting the `TORCH_DATA_VOLUME` env variable to a local directory (e.g. `./output`)

---

## 🚀 Using TORCH

The repository includes a helper script: `execute-crtdl.sh`, which allows you to run data extractions using a `CRTDL.json`.

### 📝 Step-by-Step Guide

1. **Set required environment variables**:
   ```bash
   export TORCH_BASE_URL=http://localhost:8080
   export TORCH_USERNAME=test
   export TORCH_PASSWORD=test
   ```

2. **Place your CRTDL file** in the `queries/` folder (e.g. `queries/my-test-crtdl.json`).

3. **Run the script**:
   ```bash
   ./execute-crtdl.sh -f queries/my-test-crtdl.json
   ```

4. **The script will print a URL**. Open it in a browser or fetch it with `curl`.

5. **Check extraction status**:
   - **HTTP 202**: Extraction is in progress
   - You can monitor progress via container logs:
     ```bash
     docker logs -f <torch_container_id>
     ```
   - **HTTP 200**: Extraction is complete. The response contains links to NDJSON files.

6. **Download the files** listed in the response.
   - Each file contains up to `BATCHSIZE` patient bundles, one bundle per line (NDJSON format).

7. **Validate the result** by inspecting individual bundles (each line is a complete patient resource bundle).

---

## 🧪 Extracting Specific Patients (Optional)

To extract data for specific patients (e.g., for testing), you can override cohort selection by using the `-p` option:

```bash
./execute-crtdl.sh -f queries/my-test-crtdl.json -p PATIENT-1,PATIENT-2,PATIENT-3
```

This bypasses any selection logic in the CRTDL and extracts only the specified patient IDs.

---

## 🛠️ Troubleshooting

- Ensure that all services (TORCH, FHIR, FLARE, webserver) are correctly networked and reachable.
- Review `.env` file values to ensure consistency with your environment.
- Use Docker logs to inspect runtime behavior and troubleshoot any issues:
  ```bash
  docker ps   # find container ID
  docker logs -f <container_id>
  ```
