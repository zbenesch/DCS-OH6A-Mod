# Contributing to OH-6A Mod

Thank you for your interest in the OH-6A Mod! This document explains how to contribute.

## Reporting Issues

Found a bug or have a suggestion? Please open an issue with:

1. **Clear Title**: Briefly describe the issue
2. **DCS Version**: Your DCS World version (e.g., 2.9.1)
3. **Module Version**: OH-6A version you're running (check Module Manager)
4. **Reproduction Steps**: How to reproduce the bug
5. **Expected vs Actual**: What should happen vs what happens
6. **System Info**: OS, GPU, and other relevant hardware
7. **Log Files**: Attach `Saved Games\DCS\Logs\dcs.log` if applicable

## Feature Requests

Have an idea? Open an issue with:

1. **Clear Description**: What feature and why it would be useful
2. **Implementation Ideas**: How you think it could be done
3. **Related Issues**: Link any related bug reports or requests
4. **Rationale**: Why this matters to you

## Submitting Changes

### Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/YOUR-USERNAME/DCS-OH6A-Mod.git
cd DCS-OH6A-Mod

# Create a feature branch
git checkout -b feature/your-feature-name
```

### Code Style Guidelines

**Lua Scripts:**
- Use tabs for indentation (DCS standard)
- Maximum line length: 120 characters
- Comment non-obvious logic with single-line `-- comments`
- Use descriptive variable names
- Follow existing naming conventions in the codebase

**Commit Messages:**
```
[COMPONENT] Brief description

Longer explanation if needed.

Fixes #123
```

Example: `[Cockpit] Fix gunsight reticle alignment`

### Testing Your Changes

1. **Backup Original**: Keep a backup of the original mod
2. **Install Your Changes**: Copy modified files to your DCS Mods folder
3. **Test in DCS**:
   - Verify the module loads in Module Manager
   - Test affected systems in a mission
   - Test with different aircraft configurations
4. **Document Changes**: Note what you tested
5. **Revert & Verify**: Confirm original still works

### Creating a Pull Request

1. **Push Your Branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Open a Pull Request** with:
   - Clear title and description
   - Reference to related issues
   - List of changes made
   - Testing performed
   - Any breaking changes

3. **Be Responsive**: Be prepared to address feedback or questions

## Development Tips

### Understanding the Structure

- **entry.lua** - Module initialization and configuration
- **Cockpit/Scripts/** - Instrument and system logic
- **UnitPayloads/OH-6A.lua** - Weapon loadout definitions
- **Shapes/** - 3D models and textures
- **Sounds/** - Audio files and definitions

### Useful DCS Resources

- [DCS Scripting Documentation](https://wiki.hoggitworld.com/)
- [DCS Forums](https://forums.eagle.ru/)
- [Hoggit Community Wiki](https://hoggitworld.com/)

### Common Tasks

**Modify Weapon Loadouts:**
Edit `UnitPayloads/OH-6A.lua` to add new payload configurations

**Change Cockpit Layout:**
Modify `Cockpit/Scripts/clickable_defs.lua` for clickable areas

**Update Textures:**
Replace files in `Shapes/textures/` with new DDS files

**Add Skins:**
Create new subdirectory in `Theme/` with skin textures

## Code of Conduct

- Be respectful and professional
- No discrimination or harassment
- Constructive feedback only
- Respect copyright and licensing
- Don't spam or promote other projects

## Questions?

- Check existing issues and discussions
- Review the README.md for common questions
- Open an issue with the "question" label

## Recognition

Contributors will be recognized in:
- Pull request descriptions
- Release notes
- CREDITS file (if maintained)

Thank you for contributing to the OH-6A Mod community!
