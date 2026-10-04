# OH-6A Cayuse DCS Mod

![OH-6A](https://img.shields.io/badge/DCS-Module-blue) ![Version](https://img.shields.io/badge/version-1.7-brightgreen) ![License](https://img.shields.io/badge/license-All%20Rights%20Reserved-red)

The Hughes OH-6A Cayuse is a single-engine light helicopter. Its formal name is derived from the Cayuse people, while its 'Loach' nickname comes from the acronym for the Light Observation Helicopter (LOH) program under which it was procured. During 1966, the OH-6 began service with the U.S. Army, and promptly entered active combat in the Vietnam War.

## Features

- **Full Cockpit Simulation** - Detailed cockpit with clickable controls and indicators
- **Advanced Avionics** - Compass, RWR, Gunsight, and multiple radio systems (AN/ARC-51, AN/ARC-54, AN/ARC-83, FM, UHF)
- **Gunner Position** - Complete secondary gunner station with targeting capabilities
- **Weapons Support** - Multiple weapon loadout options including miniguns, rockets, and grenades (requires weaponpack)
- **Cargo System** - Transport various cargo types (ammo, fuel, MRE, PAX, animals, etc.)
- **Multiple Viewpoints** - Pilot, gunner, and external views with customizable camera options
- **Detailed Physics** - Realistic flight model with accurate performance characteristics

## Installation

### Prerequisites
- **DCS World** (any recent version compatible with module mods)
- **OH-6A Weapons Pack** (see Dependencies below)

### Step 1: Download the Mod
1. Download this repository as a ZIP file, or clone it:
   ```bash
   git clone https://github.com/zbenesch/DCS-OH6A-Mod.git
   ```

### Step 2: Extract to DCS Mods Folder

**For Windows:**
```
C:\Users\[YourUsername]\Saved Games\DCS\Mods\aircraft\
```

Extract the `OH-6A` folder here.

**For Linux/Mac:**
```
~/.local/share/DCS/Mods/aircraft/
```

### Step 3: Install Weapons Pack
Extract the `OH-6A_Weaponpack` folder to:
```
C:\Users\[YourUsername]\Saved Games\DCS\Mods\tech\
```

### Step 4: Enable in DCS
1. Launch DCS World
2. Go to **Options → Module Manager**
3. Ensure both mods are listed and enabled:
   - ✓ OH-6A Cayuse (v1.7)
   - ✓ OH-6A Weapons (v1.2.0)

## Dependencies

### Required
- **OH-6A Weapons Pack** (v1.2.0)
  - Provides weapon definitions and payload configurations
  - Must be installed separately in `Mods/tech/OH-6A_Weaponpack/`
  - This repository includes both components

### DCS Version Compatibility
- **Minimum DCS Version**: 2.7.x
- **Tested on**: 2.8.x, 2.9.x
- **Recommended**: Latest stable DCS World release

## Directory Structure

```
OH-6A/
├── Cockpit/               # Cockpit systems and instruments
│   └── Scripts/          # Lua scripts for cockpit functionality
├── Data/                 # Cargo configuration files
├── Encyclopedia/         # In-game documentation
├── Input/               # Control bindings and input profiles
├── ImagesGui/           # UI graphics and textures
├── Kneeboard/           # Kneeboard pages
├── Missions/            # Sample missions
├── Options/             # Configuration options
├── Shapes/              # 3D models and textures
├── Sounds/              # Audio files
├── Theme/               # Skin and livery data
├── UnitPayloads/        # Weapon loadout definitions
├── bin/                 # Compiled binaries
│   ├── OH6.dll         # Flight model
│   ├── OH6GunnerTools.dll
│   ├── XH6GunnerTools.dll
│   └── cefmRadio.dll   # Radio system
├── OH6.lua             # Aircraft configuration
├── Views.lua           # Camera view definitions
├── Suspension.lua      # Landing gear physics
├── comm.lua            # Communications system
├── cargo_oh6.lua       # Cargo system
└── entry.lua           # Module entry point

OH-6A_Weaponpack/
├── Weapons/            # Weapon definitions
├── Encyclopedia/       # Weapons documentation
└── entry.lua          # Weapons module entry point
```

## Usage

### Starting a Mission
1. Open **Mission Editor** in DCS
2. Select **OH-6A Cayuse** from the helicopter list
3. Configure loadouts and options
4. Press **Start** to fly

### Keyboard Controls
- Check the **Options → Controls** menu for full binding list
- Default controls include standard helicopter pitch/roll/yaw
- Additional controls for radios, weapons, and special equipment

### Cockpit Systems
- **Intercom System** - AN/AIC-25
- **Radios** - AN/ARC-51, AN/ARC-54, AN/ARC-83, FM, UHF
- **Navigation** - VOR/DME compatible compass
- **Targeting** - Gunner station with gunsight indicator
- **Environmental** - Sun visor, doors (removable for door gunner)

## Development

### Credits
- **Aircraft Module**: Original DCS development team
- **Weapons Pack**: EightBall & Tobi

### Known Limitations
- Cockpit instruments are simulated, not fully clickable in all systems
- Some advanced avionics features may not be fully implemented
- Multiplayer synchronization may have limitations with certain weapon loadouts

### Issue Reporting
If you encounter bugs or have feature requests:
1. Check [existing issues](https://github.com/zbenesch/DCS-OH6A-Mod/issues)
2. Create a new issue with:
   - DCS version number
   - Module version numbers
   - Steps to reproduce
   - System specifications

## Troubleshooting

### Module Won't Load
- **Solution**: Verify folder placement in `Mods/aircraft/` and `Mods/tech/`
- Check DCS log file: `C:\Users\[Username]\Saved Games\DCS\Logs\dcs.log`

### Weapons Not Available
- **Solution**: Ensure OH-6A Weapons Pack is installed and enabled
- Verify both folders are in correct locations
- Restart DCS completely

### Missing Cockpit Features
- **Solution**: Update DCS to latest version
- Clear DCS shader cache: Delete `Mods\aircrafts` folder
- Restart DCS

### Performance Issues
- **Solution**: Lower graphics settings
- Disable high-LOD models if FPS is poor
- Check DCS performance monitor (Alt+Tab while in-mission)

## Contributing

This repository is for distribution of the OH-6A mod. Contributions should be made to the original development projects.

## License

All content in this repository is provided as-is for use with DCS World. See individual component licenses for detailed terms.

**Note**: This is a community distribution of the OH-6A mod. Ensure you have proper permissions before redistributing.

## Related Resources

- [DCS World Official Site](https://www.digitalcombatsimulator.com/)
- [DCS Module Documentation](https://www.digitalcombatsimulator.com/en/documentation/)
- [DCS User Forums](https://forums.eagle.ru/)

## FAQ

**Q: Can I use this in multiplayer?**  
A: Yes, all players on the server must have the mod installed.

**Q: Do I need other mods for this to work?**  
A: Only the OH-6A Weapons Pack (included). No other mods are required.

**Q: What's the difference between aircraft and weapons folders?**  
A: Aircraft folder contains the helicopter model and cockpit. Weapons folder defines the available weapons and loadouts.

**Q: Can I modify this mod?**  
A: Check the original license. Personal modifications for private use are typically allowed.

---

**Last Updated**: October 2026  
**Current Version**: 1.7 (Aircraft), 1.2.0 (Weapons)
