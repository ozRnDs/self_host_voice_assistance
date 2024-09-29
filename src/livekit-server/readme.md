# LiveKit Server Docker Image

This repository provides the steps to build, configure, and run the LiveKit Server using a Docker image. Follow the instructions below to build the image for Raspberry Pi, generate the configuration file, and run the server.

## Prerequisites

- Docker and Docker Buildx must be installed on your system.
- Ensure you have permissions to execute Docker commands.

## Steps to Build and Run the LiveKit Server for Raspberry Pi 2 Zero

### 1. **Build the Docker Image for Raspberry Pi**

To build the Docker image for Raspberry Pi, use Docker Buildx to target the `linux/arm/v7` platform. This ensures compatibility with Raspberry Pi devices.

Run the following command from the root directory where the Dockerfile is located:

```sh
docker buildx build --platform linux/arm/v7 -t ozrnds/livekit-server:v1.7.2 src/livekit-server/. --push
```

- **Options Explanation**:
  - `--platform linux/arm/v7`: Specifies that the image is to be built for Raspberry Pi's ARMv7 architecture.
  - `-t ozrnds/livekit-server:v1.7.2`: Tags the built image as `ozrnds/livekit-server:v1.7.2`.
  - `src/livekit-server/.`: Points to the directory containing the Dockerfile for building.
  - `--push`: Pushes the built image to Docker Hub.

> Note: Make sure you have logged in to Docker Hub (`docker login`) to push the image.

### 2. **Pull the Docker Image**

After building (or if using a pre-built image), you can pull the image from Docker Hub:

```sh
docker pull ozrnds/livekit-server:v1.7.2
```

This will download the Docker image tagged `v1.7.2` from the `ozrnds/livekit-server` repository.

### 3. **Generate Configuration File**

Use the Docker container to generate a default `config.yaml` file. You will need to mount a local directory to store the generated configuration file.

```sh
docker run --rm --name livekit-server-new --network host \
  -v ./[CONFIGURATION_FOLDER]:/config \
  --entrypoint /bin/sh ozrnds/livekit-server:v1.7.2 /generate_config.sh
```

- Replace `[CONFIGURATION_FOLDER]` with the local folder where you want to store the `config.yaml` file.
- This command mounts the specified local folder to `/config` inside the container and runs the `generate_config.sh` script, which creates a `config.yaml` file in the mounted folder.

### 4. **Run the LiveKit Server**

Once the configuration file is generated, you can run the LiveKit server using the following command:

```sh
docker run --rm -d --name livekit-server-new --network host \
  -v ./livekit-config:/config \
  ozrnds/livekit-server:v1.7.2 --config /config/config.yaml
```

- **Options Explanation**:
  - `--rm`: Automatically remove the container when it exits.
  - `-d`: Run the container in detached mode (in the background).
  - `--name livekit-server-new`: Assign a name to the running container.
  - `--network host`: Use the host's network stack.
  - `-v ./livekit-config:/config`: Mount the local `livekit-config` folder to `/config` inside the container. This folder should contain the `config.yaml` generated in the previous step.
  - `ozrnds/livekit-server:v1.7.2`: Specifies the Docker image to run.
  - `--config /config/config.yaml`: Passes the path to the configuration file to the server.

This command will start the LiveKit server using the generated configuration file.

## Additional Information

- The `generate_config.sh` script creates a default `config.yaml` file with randomly generated keys. You can modify this file to suit your configuration needs before starting the server.
- The server runs with network `host` mode, allowing it to share the host's network interface for lower latency.
- To stop the server, use:

  ```sh
  docker stop livekit-server-new
  ```

## Troubleshooting

- If you encounter any issues with file permissions, make sure the local directory (`[CONFIGURATION_FOLDER]`) is writable by Docker.
- Ensure that Docker has the necessary permissions to run with `--network host`, as some environments may restrict this option.

## Summary of Commands

1. **Build the Image for Raspberry Pi**:
   ```sh
   docker buildx build --platform linux/arm/v7 -t ozrnds/livekit-server:v1.7.2 src/livekit-server/. --push
   ```

2. **Pull the Docker Image**:
   ```sh
   docker pull ozrnds/livekit-server:v1.7.2
   ```

3. **Generate Configuration File**:
   ```sh
   docker run --rm --name livekit-server-new --network host \
     -v ./[CONFIGURATION_FOLDER]:/config \
     --entrypoint /bin/sh ozrnds/livekit-server:v1.7.2 /generate_config.sh
   ```

4. **Run the LiveKit Server**:
   ```sh
   docker run --rm -d --name livekit-server-new --network host \
     -v ./livekit-config:/config \
     ozrnds/livekit-server:v1.7.2 --config /config/config.yaml
   ```