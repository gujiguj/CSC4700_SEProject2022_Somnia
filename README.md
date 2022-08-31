# Somnia: A College Life Simulator
Repo for CSC 4700 Software Engineering Project Prototype of the game Somnia. Experience the wonders of time, energy, and sleep management during college life.

## [Prototype Download (TBD)]

## Built With
- [Godot Game Engine](https://godotengine.org/) and GDScript

## Getting Started

### Prerequisites
Download the Godot Game Engine [here](https://godotengine.org/download/linux#links). Somnia was built in Godot v3.4.4, so if you would like to download that instead of the latest, check it out [here](https://downloads.tuxfamily.org/godotengine/3.4.4/).

### Installation
1. Clone the repo.
2. Open Godot.
3. Select the **Import** button to open the "Import Existing Project" popup.
4. Navigate to the project directory and select the file `project.godot`.
```
../CSC4700_SEProject2022_Somnia/src/project.godot
```
5. Open the project and you're set!

### Contributing
1. Files ending with `.tscn` are scene files that are editable in the Godot GUI. Files ending with `.gd` are GDScript files associated with a scene of the same name that hold the code associated with scenes. You can navigate to the script attached to a scene by clicking the scroll icon next to a scene name when it is opened in the top-left Scene navigation menu.
2. Global variables (i.e. player health) are stored in `Global.gd`.
3. The **Tutorial Nighttime Rhythm Game** that runs at the start of the game is editable in `Tutorial.tscn` and `Tutorial.gd`.
4. The **Daytime Visual Novel Section** that runs after the tutorial rhythm game is editable in `Daytime.tscn` and `Daytime.gd`. Associated scenes (e.g. Library, DiningHall, etc.) are all accessible this way.
5. The **Nighttime Example Night Terror Rhythm Game** that runs after the Daytime is editable in `NightTerror.tscn` and `NightTerror.gd`.
