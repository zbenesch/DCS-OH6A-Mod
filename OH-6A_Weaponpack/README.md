# OH-6A Weapons Pack

![Version](https://img.shields.io/badge/version-1.2.0-brightgreen) ![Developer](https://img.shields.io/badge/developer-EightBall%20%26%20Tobi-blue)

Supporting weapons and payload configurations for the OH-6A Cayuse helicopter mod.

## Overview

This weapons pack provides all weapon definitions, ammunition types, and loadout configurations for the OH-6A aircraft. It is a **required dependency** for the main OH-6A aircraft mod to function properly.

## Features

- **Weapon Definitions** - All weapon types and their properties
- **Payload Configurations** - Pre-configured loadout options
- **Ammunition Types** - Grenades, rockets, and ammunition variants
- **Smoke Markers** - Color-coded smoke grenades (red, blue, green, yellow)
- **Loadout Restrictions** - Realistic weapon mounting constraints

## Supported Weapons

### Door Guns
- M60 Door Gun
- M134 Minigun
- XM134 Minigun

### Rockets
- XM158 Rocket Pods (2-round and 4-round variants)

### Grenades
- Fragmentation Grenades
- Smoke Grenades (multiple colors)

### Special
- Smoke markers for marking targets

## Installation

### Prerequisites
- **DCS World** 2.7.x or later
- **OH-6A Aircraft Mod** (main mod, required)

### Installation Steps

1. Extract this folder to:
   ```
   C:\Users\[YourUsername]\Saved Games\DCS\Mods\tech\
   ```

2. Ensure the folder is named exactly: `OH-6A_Weaponpack`

3. Launch DCS World

4. Go to **Options → Module Manager**

5. Verify the mod is listed and enabled:
   - ✓ OH-6A Weapons (v1.2.0)

## Directory Structure

```
OH-6A_Weaponpack/
├── Weapons/
│   ├── OH-6_weapons.lua          # Main weapon definitions
│   ├── OH-6_grenades.lua         # Grenade definitions
│   ├── OH-6_miniguns.lua         # Minigun definitions
│   └── OH-6_rockets.lua          # Rocket pod definitions
├── Encyclopedia/                 # In-game weapon documentation
└── entry.lua                     # Module entry point
```

## Weapon CLSIDs

Weapons are referenced by their CLSID (Class ID) in the main aircraft mod:

| Weapon | CLSID |
|--------|-------|
| OH6_SMOKE_RED | {OH6_SMOKE_RED} |
| OH6_SMOKE_BLUE | {OH6_SMOKE_BLUE} |
| OH6_SMOKE_GREEN | {OH6_SMOKE_GREEN} |
| OH6_SMOKE_YELLOW | {OH6_SMOKE_YELLOW} |
| OH-6 M134 Minigun | {OH-6 M134 Minigun} |
| OH-6 M60 Door | {OH-6_M60_Door} |
| OH-6 M134 Door | {OH-6_M134_Door} |
| OH6_XM158 | {OH6_XM158} |
| OH6_XM158_4 | {OH6_XM158_4} |
| OH6_FRAG | {OH6_FRAG} |

## Payload Configurations

Available loadout presets in Mission Editor:
- **Default** - Mixed smoke grenades and cannon
- **Miniguns** - Dual M134 miniguns
- **Door Guns** - Single M60 or M134 door gun
- **Rockets** - XM158 rocket pods
- **Strike** - Full weapons loadout

## Dependencies

- **OH-6A Aircraft Mod** (v1.7+) - Required
- DCS World 2.7.x or later

## Credits

- **Developers**: EightBall & Tobi
- **Weapon Models & Textures**: DCS Development Team
- **Testing & Support**: Community Contributors

## Troubleshooting

### Weapons Not Appearing in Loadouts
1. Verify weapons pack is in `Mods/tech/` folder (NOT `Mods/aircraft/`)
2. Check folder name is exactly `OH-6A_Weaponpack`
3. Restart DCS completely
4. Verify both aircraft and weapons mods are enabled in Module Manager

### Error Loading Weapons
- Check DCS log: `Saved Games/DCS/Logs/dcs.log`
- Look for weapon definition errors
- Ensure weapon pack version matches aircraft mod version

### Loadout Restrictions Not Working
- Some payloads have installation restrictions (e.g., door guns vs. external mounts)
- Check the Mission Editor loadout restrictions panel
- Refer to the restrictions defined in the aircraft's `OH-6A.lua` file

## Compatibility

- **DCS Version**: 2.7.x, 2.8.x, 2.9.x
- **OH-6A Version**: 1.7+
- **Multiplayer**: Fully supported (all players must have the mod)

## Development

### Modifying Weapons

To modify weapon properties:
1. Edit files in `Weapons/` directory
2. Reload weapon definitions in DCS
3. Test in Mission Editor loadout screen

For detailed weapon definition syntax, refer to DCS documentation.

### Adding New Weapons

To add new weapons:
1. Create weapon definition following existing syntax
2. Add CLSID reference
3. Update `OH-6A.lua` in aircraft mod if adding new mount points
4. Test in Mission Editor

## License

See LICENSE in the main OH-6A mod folder.

## Support

For issues or questions:
1. Check the main OH-6A mod README
2. Review the troubleshooting section above
3. Open an issue on GitHub: https://github.com/zbenesch/DCS-OH6A-Mod

---

**Version**: 1.2.0  
**Last Updated**: October 2026  
**Developer**: EightBall & Tobi
