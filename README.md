# 🛠️ ROS 2 Jazzy + ROBOTIS OP3 + Webots Installation Guide

This guide walks you through setting up **ROS 2 Jazzy Jalisco** with **ROBOTIS OP3** packages and **Webots simulation** on Ubuntu 24.04 (Noble) or Linux Mint 22.  
The installation is automated using the provided shell scripts.

---

## ✅ Prerequisites

- Linux Mint 22 or Ubuntu 24.04 (Noble)
- Administrative (sudo) privileges
- Internet connection
- Git and `colcon` installed

---

## 🚀 One-Step Setup (Recommended)

Run the interactive setup script to install everything in one go:

```bash
chmod +x setup.sh
./setup.sh
```

The script will:

1. Set system locale (UTF-8)
2. Enable the ROS 2 Jazzy repository
3. Install development tools
4. Install ROS 2 Jazzy Desktop
5. Install additional dependencies for OP3
6. Install ROBOTIS ROS packages
7. Run **first `colcon build`**
8. Install Webots package for OP3
9. Run **second `colcon build`**
10. Ask whether to auto-source your ROS2 workspace in `~/.bashrc` or `~/.zshrc`

### 🧑‍💻 Error Handling

If a step fails, the script will **pause** and ask:

```
Do you want to continue anyway? (y/n):
```

You can choose to continue or exit safely.

---

## 🚧 Manual Setup (Step-by-Step)

If you prefer to run the scripts manually, execute them in the following order:

### 1. 🌐 Set System Locale (UTF-8)

```bash
./set_locale.sh
```

### 2. 📦 Enable ROS 2 Repository

```bash
./enable_repo.sh
```

> **NOTE (Ubuntu only):** edit the script and replace `$UBUNTU_CODENAME` with `$VERSION_CODENAME`.

### 3. 🛠️ Install Development Tools

```bash
./install_devtools.sh
```

### 4. 🤖 Install ROS 2 Jazzy Desktop

```bash
./install_ros_jazzy.sh
```

### 5. 🔧 Install Additional Dependencies for ROBOTIS OP3

```bash
./robotis-op3/install_additional.sh
```

### 6. 🤖 Install ROBOTIS ROS Packages

```bash
./robotis-op3/install_robotis_ros_packages.sh
```

### 7. 📦 First Build

```bash
cd ~/robotis_ws
colcon build
```

### 8. 🌐 Install Webots Package

```bash
./robotis-op3/install_webots_package.sh
```

### 9. 📦 Second Build

```bash
cd ~/robotis_ws
colcon build
```

### 10. 🧪 Source ROS 2 Environment

```bash
source ~/robotis_ws/install/setup.bash
```

For convenience, add sourcing permanently:

* **Bash users**:

  ```bash
  echo "source ~/robotis_ws/install/setup.bash" >> ~/.bashrc
  ```
* **Zsh users**:

  ```bash
  echo "source ~/robotis_ws/install/setup.bash" >> ~/.zshrc
  ```

---

## 🤖 Running OP3 in Webots

Once installed and built, you can run the OP3 simulation in Webots:

1. **Source your workspace:**

   ```bash
   source ~/robotis_ws/install/setup.bash
   ```

2. **Launch the OP3 robot in Webots:**

   ```bash
   ros2 launch op3_webots_ros2 robot_launch.py
   ```

   Wait until the Webots simulator fully loads.

3. **Control the robot:**
   For example, launch the demo GUI:

   ```bash
   ros2 launch op3_gui_demo op3_demo.launch.py
   ```

---

## 📝 Notes

* If you encounter `NO_PUBKEY` or GPG errors, re-run `./enable_repo.sh`.
* Always ensure you build the workspace **twice**:

  1. After installing ROBOTIS ROS packages
  2. After installing Webots package
* You can skip auto-source in `setup.sh` and manually source your workspace if you prefer.

---

🎉 You’re now ready to develop and simulate the ROBOTIS OP3 in Webots using ROS 2 Jazzy!
