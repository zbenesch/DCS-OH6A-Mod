# Setting Up GitHub Repository for OH-6A Mod

This guide walks you through creating a GitHub repository and pushing your OH-6A mod code online.

## Prerequisites

1. **GitHub Account**: Create one at https://github.com/signup (free)
2. **Git Installed**: Download from https://git-scm.com/download/win
3. **Git Authentication**: Set up SSH or personal access token (see below)

## Step 1: Create a GitHub Repository

1. Log into GitHub
2. Click **+** (top right) → **New repository**
3. Fill in the form:
   - **Repository name**: `DCS-OH6A-Mod`
   - **Description**: `Hughes OH-6A Cayuse helicopter mod for DCS World`
   - **Visibility**: Choose **Public** (recommended for sharing) or **Private**
   - **Initialize repository**: Leave unchecked (we already have local code)
4. Click **Create repository**

## Step 2: Set Up Git Authentication

### Option A: Personal Access Token (Recommended for HTTPS)

1. On GitHub: **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token (classic)**
3. Configure:
   - **Note**: `DCS Mod Push`
   - **Expiration**: 90 days (or your preference)
   - **Scopes**: Check `repo` (full control of private repositories)
4. Click **Generate token**
5. **Copy the token immediately** (you won't see it again)

### Option B: SSH Key (More Secure)

If you prefer SSH (more secure), follow GitHub's guide:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh

## Step 3: Connect Local Repo to GitHub

Open **Git Bash** or **PowerShell** in the OH-6A folder and run:

```bash
# Navigate to the mod directory
cd "C:\Users\YOUR-USERNAME\Saved Games\DCS\Mods\aircraft\OH-6A"

# Add the remote repository (replace YOUR-USERNAME with your actual GitHub username)
git remote add origin https://github.com/YOUR-USERNAME/DCS-OH6A-Mod.git

# Rename branch to main (if needed)
git branch -M main

# Push the code to GitHub
git push -u origin main
```

**If using personal access token**: When prompted for password, paste your token.

## Step 4: Include the Weapons Pack

The weapons pack should be in a separate GitHub repository or included as a subdirectory. Option:

### Option A: Separate Repository
Create another repo for weapons:
```bash
cd "C:\Users\YOUR-USERNAME\Saved Games\DCS\Mods\tech\OH-6A_Weaponpack"
git init
git add .
git commit -m "Initial commit: OH-6A Weapons Pack v1.2.0"
git remote add origin https://github.com/YOUR-USERNAME/DCS-OH6A-Weapons.git
git branch -M main
git push -u origin main
```

### Option B: Single Repository with Both
Alternative structure:
```
DCS-OH6A-Mod/
├── aircraft/OH-6A/        # Main aircraft mod
└── tech/OH-6A_Weaponpack/ # Weapons pack
```

Then update README.md with installation instructions for this structure.

## Step 5: Verify on GitHub

1. Go to https://github.com/YOUR-USERNAME/DCS-OH6A-Mod
2. You should see:
   - All files and folders
   - README.md rendered on the main page
   - Commit history in the "commits" tab

## Step 6: Update README Links

Edit `README.md` and replace placeholders:

- Line with `github.com/YOUR-USERNAME/` → your actual username
- Line with `.gitignore` template links → your repo URL

Example:
```markdown
# Before
git clone https://github.com/YOUR-USERNAME/DCS-OH6A-Mod.git

# After
git clone https://github.com/benesch/DCS-OH6A-Mod.git
```

## Ongoing Development

### Making Updates

```bash
# Make changes to files
# Edit files, test them, etc.

# Stage changes
git add .

# Commit with descriptive message
git commit -m "[Cockpit] Fix gunsight reticle alignment"

# Push to GitHub
git push origin main
```

### Creating Releases

For version releases on GitHub:

1. Go to your repository
2. Click **Releases** (right sidebar)
3. Click **Create a new release**
4. Tag version: `v1.7` (matches mod version)
5. Release title: `OH-6A v1.7`
6. Description: List of changes and improvements
7. Click **Publish release**

Users can then download specific versions as ZIP files.

## Troubleshooting

### "fatal: not a git repository"
You're not in the mod directory. Verify with:
```bash
pwd  # Should show your OH-6A mod path
git status  # Should work if in correct directory
```

### "Authentication failed"
- **HTTPS**: Verify your personal access token is correct
- **SSH**: Check that SSH key is properly set up with GitHub
- Try: `git config --global credential.helper wincred` (Windows)

### "Remote already exists"
If you get "remote origin already exists":
```bash
git remote remove origin
git remote add origin https://github.com/YOUR-USERNAME/DCS-OH6A-Mod.git
```

### Large Files Error
If you try to push files larger than 100MB:
```bash
# See what's too large
find . -type f -size +100M

# You may need Git LFS (Large File Storage) for binaries
# Or move .dll files to git-lfs
```

For DLL files, consider using Git LFS:
```bash
git lfs install
git lfs track "*.dll"
git add .gitattributes
git commit -m "Add Git LFS tracking for DLL files"
git push origin main
```

## Next Steps

1. **Add a License** ✓ (Already included)
2. **Create Release Tags** - Tag versions (v1.7, v1.2.0, etc.)
3. **Enable Discussions** - GitHub Settings → Features → Discussions
4. **Set Up Issues** - Let users report bugs
5. **Create Releases** - For each mod version update

## Useful Links

- [GitHub Docs: Creating a Repository](https://docs.github.com/en/get-started/quickstart/create-a-repo)
- [GitHub Docs: Pushing Code](https://docs.github.com/en/get-started/using-git/pushing-commits-to-a-remote-repository)
- [Git Basics](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)

## Questions?

If you encounter issues:
1. Check GitHub's help: https://docs.github.com/
2. Check Git documentation: https://git-scm.com/doc
3. Search Stack Overflow for your error message

---

**Repository is ready!** You now have version control and can share your mod with the community.
