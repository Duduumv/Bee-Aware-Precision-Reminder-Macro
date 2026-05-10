## Precision Reminder (BeeAware)
This is a Bee Swarm Simulator helper tool developed using AutoHotkey v1.1. It was designed to solve a issue for Red Hives: the accidental loss of Precision stacks during boosts or challenges like the Stick Bug Challenge and Robo Bear Challenge.

## About
The Precision Reminder acts as a visual and auditory HUD that tracks your Precision buff in real-time. Instead of squinting at tiny icons while boosting, this tool monitors your screen and alerts you when it's time to refresh your stacks.

## Main Features
Image Recognition: Automatically detects the Precision icon anywhere on your screen using advanced ImageSearch logic.

Countdwn: A 60-second timer that resets instantly whenever a refresh is detected.

Multi-Stage Alerts: 20 Seconds: The display turns Silver with a "Refresh" message and a audio cue. 10 Seconds: The display turns Red with a "REFRESH" warning and a audio alert.

Integrated Audio Mixer: An expandable side panel with vertical sliders to control the volume of each alert type (Alert, Refresh, and Runout) individually.

Customizable HUD: A borderless, "Always-on-Top" window that can be dragged and positioned anywhere on your monitor to fit your layout.


## How it Works:
Scanning: The tool scans your screen every 200ms to find the Precision icon

Tracking: Once found, it starts a countdown. If you collect a Precise Eye in-game, the script detects the "Refreshed" state and resets the timer to 60.

Efficiency: For Red Hives, maintaining 10x Precision is vital, as roughly 75% of a Red Hive's honey comes from Super-Crits. This tool ensures you never lose that multiplier.



## Controls:
#### F6: Pause the script.
#### F7: Resume/Start the script.
#### F8: Stop and Exit the application.
#### Gear Icon (⚙️): Click to toggle the Audio Mixer settings.

## Journey:
"I started this project with zero programming knowledge. Driven by the frustration of losing stacks in important moments, I learned Python and AutoHotkey to build a solution. Today, it's a fully functional tool that helps me and can help any Red Hive player."
