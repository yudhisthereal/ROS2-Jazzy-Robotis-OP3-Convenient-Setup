#!/usr/bin/bash

echo "======================================="
echo " ROS 2 Jazzy + OP3 + Webots Setup Script"
echo "======================================="
echo ""

read -p "This will install ROS2 Jazzy and OP3 packages. Continue? (y/n): " yn
case $yn in
    [Yy]* ) ;;
    * ) echo "❌ Aborted."; exit 1;;
esac

run_step () {
    echo ""
    echo "---------------------------------------"
    echo "▶️  $1"
    echo "---------------------------------------"
    shift
    if "$@"; then
        echo "✅ Done."
    else
        echo "❌ Error while running: $*"
        while true; do
            read -p "Do you want to continue anyway? (y/n): " choice
            case $choice in
                [Yy]* ) echo "⚠️  Continuing despite error."; return 0;;
                [Nn]* ) echo "❌ Exiting."; exit 1;;
                * ) echo "Please answer y or n.";;
            esac
        done
    fi
}

# Steps
run_step "Setting locale" ./set_locale.sh
run_step "Enabling ROS2 repository" ./enable_repo.sh
run_step "Installing development tools" ./install_devtools.sh
run_step "Installing ROS2 Jazzy Desktop" ./install_ros_jazzy.sh
run_step "Installing additional OP3 dependencies" ./robotis-op3/install_additional.sh
run_step "Installing ROBOTIS ROS packages" ./robotis-op3/install_robotis_ros_packages.sh

run_step "First colcon build" bash -c "cd ~/robotis_ws && colcon build"

run_step "Installing Webots package" ./robotis-op3/install_webots_package.sh
run_step "Installing ROS2 Jazzy Webots" ./robotis-op3/install_ros2_jazzy_webots.sh

run_step "Second colcon build" bash -c "cd ~/robotis_ws && colcon build"

echo ""
echo "======================================="
echo " 🎉 All installations completed!"
echo "======================================="
echo ""
echo "To start using ROS2 Jazzy with OP3:"
echo "  source ~/robotis_ws/install/setup.bash"
echo ""

# Ask for shell type
echo "Which shell do you use?"
select shell_choice in "bash" "zsh" "skip"; do
    case $shell_choice in
        bash)
            SHELL_RC="$HOME/.bashrc"
            break
            ;;
        zsh)
            SHELL_RC="$HOME/.zshrc"
            break
            ;;
        skip)
            SHELL_RC=""
            break
            ;;
        *)
            echo "Invalid option. Please select 1, 2, or 3."
            ;;
    esac
done

if [ -n "$SHELL_RC" ]; then
    echo "source ~/robotis_ws/install/setup.bash" >> "$SHELL_RC"
    echo "✅ Added auto-source to $SHELL_RC"
else
    echo "ℹ️ Skipped auto-source. You can manually add:"
    echo "   source ~/robotis_ws/install/setup.bash"
fi
