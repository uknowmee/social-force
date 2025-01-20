# [Social Force](../README.md) - docs

- [Google Drive](https://drive.google.com/drive/folders/1fYhy4z2WyO3nTTqFXY9N77humMqNLsmJ?usp=sharing)
- [Project classes .md](Agent_systems_ansi.md)
- Project Engine [.zip](../engines/Godot_v4.3-stable_win64.exe.zip) [download](https://godotengine.org/download/archive/4.3-stable/)
- Archived Project Engine [.zip](../engines/Godot_v3.5-stable_win64.exe.zip) [download](https://godotengine.org/download/archive/3.5-stable/)
- [Archived Project](../archive)

## Report

```bash
# Build container
docker build -t pandocker .

# Collect artifact
docker run --rm -u $UID:$GID -v .:/data pandocker ./report/*.md -o ./report.pdf
```

or

```bash
# Install pandoc
sudo apt update && sudo apt install -y pandoc texlive-full

# Collect artifact
pandoc report/*.md -o report.pdf
```
