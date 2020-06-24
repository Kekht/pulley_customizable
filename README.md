# Pulley (customizable)

This is OpenSCAD script for modelling different timing belt pulleys, that could be printed on regular FDM printer.

## Available options

  * Profile
    * Number of teeth (10-100)
    * Teeth profile:
        * MXL
        * 40DP
        * XL
        * H
        * T2.5
        * T5
        * T10
        * AT5
        * HTD (3 mm, 5 mm, 8 mm)
        * GT2 (2 mm, 3 mm, 5 mm)
    * Motor shaft diameter
    * Toothed part length (3-30 mm)
    * Height of "base" (0-30 mm)*
    * Diameter of "base" (10-50 mm)**
  * Top and Bottom flanges
    * Enable or disable top flange
    * Top flange height (above tooth)
    * Top flange width (thickness of flange)
    * Enable or disable bottom flange
    * Bottom flange height (above tooth)
    * Bottom flange width (thickness of flange)
    * Set bottom flange bottom surface diameter equal to the base diameter
  * Holding _(configures holding screws and nuts placeholders)_
    * Screws disposition
      * None _(disables placeholders)
      * 1 screw
      * 2 screws at 90 deg
      * 3 screws at 120 deg
      * 4 screws at 90 deg
    * Nut shape
      * Hexagonal
      * Square
    * Screw profile
      * M1
      * M1.6
      * M2
      * M2.5
      * M3
      * M4
      * M5
      * M6
    * Nut shaft distance _(distance in mm between inner face of nut and shaft)_
  * Idler Bearings _(This section allows to configure grooves to insert bearings)_
    * Add bearing grooves _(enables or disables bearing grooves)_
    To actually enable this 
    * Bearing grooves diameter _(should be close to bearing outer diameter)_
    * Bearing grooves height _(should be close to bearing width)_
  * Tweaks
    * Additional tooth width _(Scaling tooth for good fit)_
    * Additional tooth depth _(If you need more tooth depth than this provides, adjust the constant above. However, this will cause the shape of the tooth to change)_
    * Surfaces_quality _(Polygon multiplier for smoother surfaces, not influence tooth profile)_
      * Standard
      * High
      * Highest
      * Best
    * Flip pulley upside down _(if pulley diameter bigger than bese, you can flip it upside down right here for easier 3D-printing)_

_* to produce holes for holding bolts and nuts, **base height** + **bottom flange width** should correspond to nuts used, for example greater than 7 mm for M3 nuts_

_** to produce holes for holding bolts and nuts, **base diameter** should correspond to nuts used_

## Authors and contributors

This project is my attempt to organise a little this usefull thing and share for further improvements.
Initially it was made by droftarts @ January 2012, I've found it on thingiverse, published by D14 @ October 30, 2016.
