# PIProxy

Useful batch/powershell wrapper for running pip behind company PAC file.
Uses powershell to query the proxy address for the pip repository and then sets it before calling pip.


## Setup
- Run `pipr.ps1` using powershell to create the batch wrapper, or simply download the ready made one.
- Put the batch script in your PATH.

## Run
Use pipr the same you would have used pip. For example:
```
pipr install nop
```
### Notes
* Running the batch script will work regardless of the powershell execution policy.
