# Windows Telemetry & OneDrive Toggle Script

If Requesting administrator priviledges takes long just run it as an administrator.

This script lets you easily toggle Windows telemetry, block or uninstall OneDrive, and disable common background services for better privacy and performance. It provides a simple menu to:

- Disable or enable all major telemetry and data collection settings
- Block, enable, or uninstall OneDrive
- Disable background apps and unnecessary services
- View the status of telemetry, OneDrive, and key background services

<p align="center">
  <img src="https://github.com/user-attachments/assets/013021c8-1698-4e8b-a993-f89cd7ca7f60" alt="Project Screenshot" width="500"/>
</p>

## Technical Details

- All telemetry/privacy toggles are managed via registry keys (see KEY/VAL variables at the top of the script).
- Service disabling uses `sc stop` and `sc config` commands.
- The menu and status display use standard batch logic and loops.
- To add or change registry settings, edit the KEY/VAL and DESC variables and update the enable/disable sections.
- To add more services, update the :servicestatus calls and the :disablebgapps section.
- The script must be run as administrator to make system changes.
