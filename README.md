# RetroArch BIOS Verification Tools

see organize_retroarch_bios which should be ran like

```
git clone https://github.com/libretro/docs.git docs
mkdir -p BIOS # Put your classic BIOS files in here
./organize_retroarch_bios -d docs -e ./extra_bios_docs/ -b BIOS
```

This will then

 * Check all the MD5's of the files
 * Move ones that match at least one BIOS in the RetroArch docs into BIOS_FILES/_veriried/<MD5>
 * Move files which don't match any MD5's into BIOS_FILES/_unverified
 * Create a symlink from BIOS_FILES/<SYSTEM_NAME>/<Filename> to BIOS_FILES/_verified/<MD5>
 * Create a symlink from BIOS_FILES/<Filename> to BIOS_FILES/_verified/<MD5>
 * Create three text files called `_bios_set_complete.txt`, `_bios_set_incomplete.txt` and `_bios_set_missing.txt` to tell which systems have all / some / none of the BIOS files.

