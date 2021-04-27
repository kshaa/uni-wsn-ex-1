# LU DF BST/WSN uni course EDI Testbed exercise no. 1

## Exercise
See exercise definition in latvian in [Leo Selavo course site](http://andromeda.df.lu.lv/wiki/index.php/LU-BST-b#Programma_P1)  

## Environment (Nix)
- [Install Nix](https://github.com/NixOS/nix)  
- [Configure experimental nix flakes](https://gist.github.com/kshaa/f1ac85c3d9db8e7c8e92863a51bbf136)  
- Run `nix develop`  

_Note: This shell provides `MansOS` in [`$MANS_OS_SOURCE`](https://github.com/edi-riga/MansOS), [`edi_testbed_cli`](http://git.edi.lv/TestBed/edi-testbed-cli) and `python3`_  
_Note: `nixpkgs` currently seems to not include `msp430-gcc` so the nix shell can't be completely pure, because you must bring your own `msp430-gcc` in `$PATH` i.e. `-i` flag won't work_  

## Environment (Ubuntu)
- Download [MansOS](https://github.com/edi-riga/MansOS)  
- Set environment variable for `Makefile` e.g. `export  MOSROOT=<path_to_mans_os_download>`  
- Download [`edi_testbed_cli`](http://git.edi.lv/TestBed/edi-testbed-cli)  
- Add executable bit w/ `chmod +x edi_testbed_cli`  
- Store `edi_testbed_cli` somewhere in `$PATH` or configure it manually `export PATH="$PATH:<path_to_edi_testbed_cli_dir>"`  
- Download [python3](https://www.python.org/downloads/)  
- `make setup`  

## Development
- `make pc`  
- `make run`  

## Deployment to EDI Testbed
Build firmware:  
```bash
make xm1000
```

Connect to EDI Testbed infrastructure:  
```bash
export USER="pass show <testbeduser>"
export PASS="pass show <testbedpass>"
edi_testbed_cli connect -u $USER -p $PASS
```

For convenience (EDI CLI accepts only files from cwd) link built image to repo root:
```bash
ln -s build/xm1000/image.ihex xm1000.ihex
```

Execute & report testbed project:
```bash
# Create new project
edi_testbed_cli project -n exercise_1

# Configure experiment runtime to 105s (5s more than it should actually take)
edi_testbed_cli config -d 105

# Upload built microcontroller firmware image to Testbed project
edi_testbed_cli upload -n version_1 xm1000.ihex

# (Optional) Re-assign available Testbed microcontrollers (i.e. a.b.c) to run this uploaded image
# (Optional) Re-upload the image to re-assign all microcontrollers
edi_testbed_cli status
edi_testbed_cli assign version_1 a.b.c

# Run an experiment with the current project setup
edi_testbed_cli start -n experiment_1

# (Optional) Run the experiment with `-r` flag to follow runtime logs
edi_testbed_cli start -n experiment_1 -r

# Download mote logs after the experiment has ended (approx. extra 20s for start-up & finish-up)
sleep 120s
edi_testbed_cli download -t experiment_1

# Extract mote logs
mkdir experiment_1 && unzip -d experiment_1 experiment_1_logs.zip && rm experiment_1_logs.zip
```
