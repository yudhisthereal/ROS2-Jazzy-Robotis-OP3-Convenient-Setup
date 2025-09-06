# 🛠️ ROS 2 Jazzy Installation Guide

This guide will walk you through setting up **ROS 2 Jazzy Jalisco** on a supported Ubuntu 24.04 (Noble) or compatible system like Linux Mint 22.  
The process is automated through shell scripts provided in this repository.

---

## ✅ Prerequisites

- Linux Mint 22 or Ubuntu 24.04 (Noble)
- Administrative (sudo) privileges
- Internet connection

---

## 🚧 Step 1: Make Shell Scripts Executable

Before running the setup scripts, ensure all `.sh` files have execute permissions.

```bash
chmod +x *.sh
chmod +x robotis-op3/*.sh
````

---

## 🚀 Step 2: Execute Setup Scripts in Order

Run each script one at a time **in the following order**:

### 1. 🌐 Set System Locale (UTF-8)

```bash
./set_locale.sh
```

Ensures the system uses a UTF-8 locale required by ROS 2.

---

### 2. 📦 Enable ROS 2 Repository

```bash
./enable_repo.sh
```
> **NOTE:** If you're on Ubuntu, edit the script to replace `$UBUNTU_CODENAME` with `$VERSION_CODENAME`.

Adds the ROS 2 Jazzy APT repository and GPG key for package verification.

---

### 3. 🛠️ Install Development Tools

```bash
./install_devtools.sh
```

Installs required build tools and dependencies for compiling ROS 2 packages.

---

### 4. 🤖 Install ROS 2 Jazzy Desktop

```bash
./install_ros_jazzy.sh
```

Installs the main ROS 2 Jazzy desktop package and common tools.

---

### 5. 🔧 Install Additional Dependencies for ROBOTIS OP3

```bash
./robotis-op3/install_additional.sh
```

Updates the package list, installs `python3-rosdep`, and initializes and updates `rosdep` for managing ROS package dependencies.
> NOTE: if there's an error like "ERROR: default sources list file already exists" it means you've already done this before. Just proceed with the next step :)

---

### 6. 🤖 Install ROBOTIS ROS Packages

```bash
./robotis-op3/install_robotis_ros_packages.sh
```

Clones ROS packages for OP3 robot control, including for Gazebo and Webots simulations!

---

## 🧪 Final Step: Source ROS 2 Environment

After successful installation, source the ROS 2 setup script:

```bash
source ~/robotis_ws/install/setup.bash
```

For convenience, add this line to your `~/.bashrc`:

```bash
echo "source ~/robotis_ws/install/setup.bash" >> ~/.bashrc
```

---

## 📦 Workspace (Optional)

If using a custom ROS 2 workspace (e.g. `~/ros2_ws`), be sure to source it after building:

```bash
source ~/ros2_ws/install/setup.bash
```

Again, for convenience, add this line to your `~/.bashrc`:

```bash
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
```

---

## OP3 Webots Simulation with ROS2

Follow these steps to launch and control the OP3 robot in Webots using ROS2:

1. **Source your ROS2 workspace:**

   ```bash
   source ~/robotis_ws/install/setup.bash
   ```

2. **Launch the OP3 robot in Webots:**

   ```bash
   ros2 launch op3_webots_ros2 robot_launch.py
   ```

   Wait for the Webots simulator to fully load.

3. **Control the robot via ROS2:**

   Once Webots is running, you can control the robot using any compatible ROS2 package. For example, try:

   ```bash
   ros2 launch op3_gui_demo op3_demo.launch.py
   ```

You're now ready to interact with the OP3 robot in simulation using ROS2!

---

## 📝 Notes

* If you encounter GPG errors (e.g. `NO_PUBKEY`), check if line 7 in `enable_repo.sh` is working. Then try running `./enable_repo.sh` again.
* Ensure you run these scripts **one at a time**, and watch for any installation prompts or errors.
