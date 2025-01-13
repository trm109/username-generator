# Really dumb package to generate name combinations and have it speak to you.
No seriously, its super stupid. I made the core functionality in under 30 minutes, then spent a few hours making it presentable (for fun).
## Context
I wanted to create similar-vibe names for my girlfriend and I to use for the upcoming Monster Hunter Wilds release.
## Requirements
- [Nix Package Manager](https://nixos.org/download/)
    - It is heavily recommended to follow the 'Multi-user installation' version.
    - Note that NixOS != Nix (package manager). You can be on ubuntu, arch, whatever--as long as you have the `nix` package you can run this.
- [Devenv](https://devenv.sh/)
- [Direnv](https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=direnv) (Optional but recommended)
    - This just automatically runs `devenv` when you enter a directory with `direnv` and `devenv` resources. very useful.
## Resources/Folder structure
- `model/`: tts voice model stuff. rename the model `.onnx` file to `tts.onnx`, and the config `.onnx.json` to `tts.onnx.json`
- `input/`: Contains `first_names.txt`, `last_names.txt`, and `greetings.txt`
- `output/`: Contains `combinations.txt`

## Running
1. Modify your first names, last names, and greetings in the `input/` folder
2. Download your preferred model AND config. You can find these [here](https://github.com/rhasspy/piper/blob/master/VOICES.md)
3. Place the files into `input/`, ex; `mv ~/Downloads/en_GB-alan-medium.onnx ./model/tts.onnx && mv ~/Downloads/en_en_GB_alan_medium_en_GB-alan-medium.onnx.json ./model/tts.onnx.json`
3. Run the provided `generate.sh` file.
    - This will generate all possible combinations of the first & last names, shuffle them, and put them into `output/combinations.txt`
4. To listen to them, run `listen.sh`
