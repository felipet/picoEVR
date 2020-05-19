# picoEVR - FPGA firmware

This is the very beginning of an effort to develop an [MRF](http://www.mrf.fi/) 
Event Receiver using the picoZED SOM + the carrier board developed by the
TalTech University in Estonia.

This project will be based on:
- [The OpenEVR project](https://github.com/jpietari/mrf-openevr)
- The carrier board for the picoZED from TTU (aka [FPGA-based IOC](https://confluence.esss.lu.se/display/HAR/picoZED+carrier+board))

## Cloning the repository

The project uses nested submodules (submodules within submodules) to source the various IP blocks used in the design. To correctly initialise the submodules, run the following:

`    git clone --branch openevr --recurse-submodules git@gitlab.esss.lu.se:tallinn-in-kind/picoevr.git`

...or

`    git clone git@gitlab.esss.lu.se:tallinn-in-kind/picoevr.git && cd picoevr`

`    git checkout openevr`

`    git submodule update --init --recursive`

## Startup steps

In order to start playing with the project, the complete Vivado project structure must be generated.
To do so, just type: ```make project``` and the project will be generated at *fpga/output/vivado_project*.
Then compile as usual using the Vivado GUI.

## Related projects

- [ESS YoctoLinux](https://gitlab.esss.lu.se/icshwi/yocto-ess/)
- [HW design of the carrier board](https://gitlab.esss.lu.se/tallinn-in-kind/fpgaioc-hw)
- [Supervisor CPU firmware](https://gitlab.esss.lu.se/tallinn-in-kind/miniioc)

## Collaborate

If you want to collaborate or ask any question, please contact any of the 
project maintainers:
- Ross Elliot <ross.elliot@ess.eu>
- Felipe Torres González <felipe.torresgonzalez@ess.eu>
