// Parametric Pulley with multiple belt profiles
// by droftarts January 2012
// improved by Kekht @ June 2020

// Based on pulleys by:
// http://www.thingiverse.com/thing:11256 by me!
// https://github.com/prusajr/PrusaMendel by Josef Prusa
// http://www.thingiverse.com/thing:3104 by GilesBathgate
// http://www.thingiverse.com/thing:2079 by nophead

// dxf tooth data from http://oem.cadregister.com/asp/PPOW_Entry.asp?company=915217&elementID=07807803/METRIC/URETH/WV0025/F
// pulley diameter checked and modelled from data at http://www.sdp-si.com/D265/HTML/D265T016.html

/**
 * @name Pulley
 * @category Printed
 * @using 1 x m3 nut, normal or nyloc
 * @using 1 x m3x10 set screw or 1 x m3x8 grub screw
 */

//	****************************
//	*** CONFIGURABLE OPTIONS ***
//	****************************

/* [Profile] */

number_of_teeth = 20; // [10:100]

profile = 12; // [1:MXL, 2:40DP, 3:XL, 4:H, 5:T2.5, 6:T5, 7:T10, 8:AT5, 9:HTD_3mm, 10:HTD_5mm, 11:HTD_8mm, 12:GT2_2mm, 13:GT2_3mm, 14:GT2_5mm]

// (in mm)
motor_shaft_diameter = 5;

// (in mm)
toothed_part_length = 6; // [3:30]

// (in mm)
base_height = 7; // [0:30]

// (in mm)
base_diameter = 18;     // [10:50]

/* [Top and Bottom flanges] */

top_flange = 1; // [0:No, 1:Yes]

top_flange_height = 3; // [0.5:Tiny (0.5mm), 1:Small (1mm), 1.5:Normal (1.5mm), 2:Big (2mm), 3:Bigger (3mm), 4:Hudge (5mm), 1.66: Powge 16T, 2.89:Powge 20T, 2.295: Powge 25T, 2.205:Powge 30T]

top_flange_width = 1; // [0:None, 0.5:Tiny (0.5mm), 1:Small (1mm), 1.5:Normal (1.5mm), 2:Big (2mm), 3:Bigger (3mm), 4:Hudge (5mm)]

bottom_flange = 1; // [0:No, 1:Yes]

// Height of idler flange over pulley. Set to same as base height if you want an idler but no pulley.
bottom_flange_height = 1; // [0.5:Tiny (0.5mm), 1:Small (1mm), 1.5:Normal (1.5mm), 2:Big (2mm), 3:Bigger (3mm), 4:Hudge (5mm), 1.66: Powge 16T, 2.89:Powge 20T, 2.295: Powge 25T, 2.205:Powge 30T]

bottom_flange_width = 1; // [0:None, 0.5:Tiny (0.5mm), 1:Small (1mm), 1.5:Normal (1.5mm), 2:Big (2mm), 3:Bigger (3mm), 4:Hudge (5mm)]

bottom_flange_diameter_equal_base = 1; // [0:No, 1:Yes]

/* [Holding] */

screws_disposition = 2; // [0:None, 1:1 screw, 2:2 screws at 90 deg, 3:3 screws at 120 deg, 4:4 screws at 90 deg]

nut_shape = 1; // [1:Hexagonal, 0:Square]

screw_profile = 4; // [0:M1, 1:M1.6, 2:M2, 3:M2.5, 4:M3, 5:M4, 6:M5, 7:M6]

// Distance between inner face of nut and shaft - can be negative - (in mm).
nut_shaft_distance = 1.2;

/* [Idler Bearings] */

// Set screws_disposition to None to enable bearing grooves
add_bearing_grooves = 0; // [0:No, 1:Yes]

// (in mm)
bearing_grooves_diameter = 5; // [5:30]

// (in mm)
bearing_grooves_height = 2.5; // [2.5:2.5 mm, 3:3 mm, 4:4 mm, 5:5 mm, 6:6 mm, 7:7 mm, 8:8 mm, 9:9 mm]

//    ********************************
//    ** Scaling tooth for good fit **
//    ********************************
/*    To improve fit of belt to pulley, set the following constant. Decrease or increase by 0.1mm at a time. We are modelling the *BELT* tooth here, not the tooth on the pulley. Increasing the number will *decrease* the pulley tooth size. Increasing the tooth width will also scale proportionately the tooth depth, to maintain the shape of the tooth, and increase how far into the pulley the tooth is indented. Can be negative */
/* [Tweaks] */

// Scaling tooth for good fit
additional_tooth_width = 0.2; //mm

//    If you need more tooth depth than this provides, adjust the constant above. However, this will cause the shape of the tooth to change.
additional_tooth_depth = 0; //mm

// Polygon multiplier for smoother surfaces
surfaces_quality = 4; // [4:Standard, 8:High, 16:Highest, 32:Best]

flip_pulley_upside_down = 0;// [0:No, 1:Yes]

//	*********************************************************
//	*** IF CONFIGURING - PLEASE DO NOT TOUCH FURTHER CODE ***
//	*********************************************************

/* [Hidden] */

no_of_nuts = screws_disposition;
nut_angle = no_of_nuts != 3 ? 90 : 120;

motor_shaft = motor_shaft_diameter + 0.2;

screw_diameters = [1, 1.6, 2, 2.5, 3, 4, 5, 6];
nut_widths = [2.5, 3.2, 4, 5, 5.5, 7, 8, 10];
nut_depths = [1, 1.3, 1.6, 2, 2.4, 3.2, 4.7, 5.2];

screw_diameter = screw_diameters[screw_profile] + 0.2;
nut_width = nut_widths[screw_profile] + 0.2;
nut_depth = nut_depths[screw_profile] + 0.3;

// calculated constants

base_shift = ( bottom_flange > 0 ) ? bottom_flange_width : 0;
true_base_height = base_height + base_shift;
nut_elevation = base_height/2;
m3_nut_points = 2*((nut_width/2)/cos(30)); // This is needed for the nut trap

bearing_grooves_enabled = screws_disposition > 0 ? 0 : add_bearing_grooves;
polygon_multiplier = surfaces_quality;

// The following set the pulley diameter for a given number of teeth

MXL_pulley_dia = tooth_spacing (2.032, 0.254);
40DP_pulley_dia = tooth_spacing (2.07264, 0.1778);
XL_pulley_dia = tooth_spacing (5.08, 0.254);
H_pulley_dia = tooth_spacing (9.525, 0.381);
T2_5_pulley_dia = tooth_spaceing_curvefit (0.7467, 0.796, 1.026);
T5_pulley_dia = tooth_spaceing_curvefit (0.6523, 1.591, 1.064);
T10_pulley_dia = tooth_spacing (10, 0.93);
AT5_pulley_dia = tooth_spaceing_curvefit (0.6523, 1.591, 1.064);
HTD_3mm_pulley_dia = tooth_spacing (3, 0.381);
HTD_5mm_pulley_dia = tooth_spacing (5, 0.5715);
HTD_8mm_pulley_dia = tooth_spacing (8, 0.6858);
GT2_2mm_pulley_dia = tooth_spacing (2, 0.254);
GT2_3mm_pulley_dia = tooth_spacing (3, 0.381);
GT2_5mm_pulley_dia = tooth_spacing (5, 0.5715);


// The following calls the pulley creation part, and passes the pulley diameter and tooth width to that module

if ( profile == 1 ) { pulley_opt ( "MXL" , MXL_pulley_dia , 0.508 , 1.321 , flip_pulley_upside_down ); }
if ( profile == 2 ) { pulley_opt ( "40 D.P." , 40DP_pulley_dia , 0.457 , 1.226 , flip_pulley_upside_down ); }
if ( profile == 3 ) { pulley_opt ( "XL" , XL_pulley_dia , 1.27, 3.051 , flip_pulley_upside_down ); }
if ( profile == 4 ) { pulley_opt ( "H" , H_pulley_dia , 1.905 , 5.359 , flip_pulley_upside_down ); }
if ( profile == 5 ) { pulley_opt ( "T2.5" , T2_5_pulley_dia , 0.7 , 1.678 , flip_pulley_upside_down ); }
if ( profile == 6 ) { pulley_opt ( "T5" , T5_pulley_dia , 1.19 , 3.264 , flip_pulley_upside_down ); }
if ( profile == 7 ) { pulley_opt ( "T10" , T10_pulley_dia , 2.5 , 6.13 , flip_pulley_upside_down ); }
if ( profile == 8 ) { pulley_opt ( "AT5" , AT5_pulley_dia , 1.19 , 4.268 , flip_pulley_upside_down ); }
if ( profile == 9 ) { pulley_opt ( "HTD 3mm" , HTD_3mm_pulley_dia , 1.289 , 2.27 , flip_pulley_upside_down ); }
if ( profile == 10 ) { pulley_opt ( "HTD 5mm" , HTD_5mm_pulley_dia , 2.199 , 3.781 , flip_pulley_upside_down ); }
if ( profile == 11 ) { pulley_opt ( "HTD 8mm" , HTD_8mm_pulley_dia , 3.607 , 6.603 , flip_pulley_upside_down ); }
if ( profile == 12 ) { pulley_opt ( "GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 , flip_pulley_upside_down ); }
if ( profile == 13 ) { pulley_opt ( "GT2 3mm" , GT2_3mm_pulley_dia , 1.169 , 2.31 , flip_pulley_upside_down ); }
if ( profile == 14 ) { pulley_opt ( "GT2 5mm" , GT2_5mm_pulley_dia , 1.969 , 3.952 , flip_pulley_upside_down ); }

// Functions

function tooth_spaceing_curvefit (b, c, d)
    = ((c * pow(number_of_teeth, d)) / (b + pow(number_of_teeth, d))) * number_of_teeth ;

function tooth_spacing(tooth_pitch, pitch_line_offset)
    = (2*((number_of_teeth*tooth_pitch)/(3.14159265*2)-pitch_line_offset)) ;

module pulley_opt(belt_type, pulley_OD, tooth_depth, tooth_width, flip_pulley) {
    if (flip_pulley > 0) {
        translate ([0, 0, true_base_height + toothed_part_length + 1 ])
          rotate ([0, 180, 0])
            pulley(belt_type, pulley_OD, tooth_depth, tooth_width);
    } else {
        pulley(belt_type, pulley_OD, tooth_depth, tooth_width);
    }
}

// Main Module
module pulley(belt_type, pulley_OD, tooth_depth, tooth_width) {
    echo (str("Belt type = ", belt_type,"; Number of teeth = ", number_of_teeth,"; Pulley Outside Diameter = ", pulley_OD,"mm "));
    tooth_distance_from_centre = sqrt( pow(pulley_OD/2, 2) - pow((tooth_width+additional_tooth_width)/2, 2));
    tooth_width_scale = (tooth_width + additional_tooth_width ) / tooth_width;
    tooth_depth_scale = ((tooth_depth + additional_tooth_depth ) / tooth_depth) ;

    difference() {
        union() {
            //base
    
            if ( true_base_height < 2 ) { 
                echo ("CAN'T DRAW PULLEY BASE, HEIGHT LESS THAN 2!!!"); 
            } else {
                rotate_extrude($fn=base_diameter*(polygon_multiplier*2)) 
                  square([base_diameter/2, true_base_height - base_shift]);
            }
    
            difference() {
                //shaft - diameter is outside diameter of pulley
                
                translate([0, 0, true_base_height]) 
                  rotate ([0, 0, 360/(number_of_teeth*4)]) 
                    cylinder(d=pulley_OD, h=toothed_part_length, $fn=number_of_teeth*polygon_multiplier);

                //teeth - cut out of shaft
                for (i=[1:number_of_teeth]) 
                  rotate([0, 0, i*(360/number_of_teeth)])
                    translate([0, -tooth_distance_from_centre, true_base_height -1]) 
                      scale ([ tooth_width_scale, tooth_depth_scale, 1 ])
                {
                    if ( profile == 1 ) { MXL();}
                    if ( profile == 2 ) { 40DP();}
                    if ( profile == 3 ) { XL();}
                    if ( profile == 4 ) { H();}
                    if ( profile == 5 ) { T2_5();}
                    if ( profile == 6 ) { T5();}
                    if ( profile == 7 ) { T10();}
                    if ( profile == 8 ) { AT5();}
                    if ( profile == 9 ) { HTD_3mm();}
                    if ( profile == 10 ) { HTD_5mm();}
                    if ( profile == 11 ) { HTD_8mm();}
                    if ( profile == 12 ) { GT2_2mm();}
                    if ( profile == 13 ) { GT2_3mm();}
                    if ( profile == 14 ) { GT2_5mm();}
                }

            }
            
            // belt retainer / idler // top_flange_width
            flange_spare_height = (top_flange_height < tooth_depth) || (bottom_flange_height < tooth_depth) ? 0 : tooth_depth;
            if ( top_flange > 0 ) {
                // echo(str("flange_spare_height = ", flange_spare_height,"; top_flange_height = ", top_flange_height,"; tooth_depth = ", tooth_depth));
                translate([0, 0, true_base_height + toothed_part_length ]) 
                  rotate_extrude($fn=number_of_teeth*polygon_multiplier)  
                    polygon([
                        [0, 0],
                        [pulley_OD/2 + flange_spare_height, 0],
                        [pulley_OD/2 + top_flange_height, top_flange_width / 3],
                        [pulley_OD/2 + top_flange_height, top_flange_width],
                        [0 , top_flange_width],
                        [0, 0]
                    ]);
            }
        
            if ( bottom_flange > 0 ) {
                bottob_flange_bottom_diameter = bottom_flange_diameter_equal_base ? base_diameter/2 : pulley_OD/2 + bottom_flange_height;
                translate([0, 0, true_base_height - bottom_flange_width ]) 
                  rotate_extrude($fn=number_of_teeth*polygon_multiplier)  
                    polygon([
                        [0, 0],
                        [bottob_flange_bottom_diameter, 0],
                        [bottob_flange_bottom_diameter, bottom_flange_width * 2/3],
                        [pulley_OD/2 + flange_spare_height, bottom_flange_width],
                        [0 , bottom_flange_width],
                        [0, 0]
                    ]);
            }

        }
       
        //hole for motor shaft
        translate([0, 0, -1])
          cylinder(d=motor_shaft, h=true_base_height + toothed_part_length + top_flange_width + 2, $fn=motor_shaft*polygon_multiplier);
        
        if (bearing_grooves_enabled > 0) {
          translate([0, 0, -1])
            cylinder(d=bearing_grooves_diameter, h=bearing_grooves_height + 1, $fn=bearing_grooves_diameter*polygon_multiplier*4);

          translate([0, 0, base_height + bottom_flange_width + toothed_part_length + top_flange_width - bearing_grooves_height ])
            cylinder(d=bearing_grooves_diameter, h=bearing_grooves_height + 1, $fn=bearing_grooves_diameter*polygon_multiplier*4);
        }

        //captive nut and grub screw holes
        if (no_of_nuts > 0) {
          base_height_threshold = ( nut_shape > 0 ) ? m3_nut_points + 0.5 : nut_width;
          if ( true_base_height < base_height_threshold ) {
              echo ("CAN'T DRAW CAPTIVE NUTS, HEIGHT LESS THAN NUT DIAMETER!!!");
          } else {
              if ( (base_diameter - motor_shaft)/2 < nut_depth + 3 ) {
                  echo ("CAN'T DRAW CAPTIVE NUTS, DIAMETER TOO SMALL FOR NUT DEPTH!!!");
              } else {
      
                  for (j=[1:no_of_nuts])
                    rotate([0, 0, j*nut_angle])
                      translate([0, 0, nut_elevation])
                        rotate([90, 0, 0])
                  union() {
                      //entrance
                      translate([0, -base_height/4-0.5, motor_shaft/2+nut_depth/2+nut_shaft_distance])
                        cube([nut_width, base_height/2+1, nut_depth], center=true);

                      //nut
                      if ( nut_shape > 0 ) {
                          // hex nut
                          translate([0, 0.25, motor_shaft/2+nut_depth/2+nut_shaft_distance])
                            rotate([0, 0, 30])
                              cylinder(d=m3_nut_points, h=nut_depth, center=true, $fn=polygon_multiplier*1.5);
                      } else {
                          // square nut
                          translate([0, 0.25, motor_shaft/2+nut_depth/2+nut_shaft_distance])
                            cube([nut_width, nut_width, nut_depth], center=true);
                      }

                      //grub screw hole
                      rotate([0, 0, 22.5])
                        cylinder(d=screw_diameter, h=base_diameter/2+1, $fn=polygon_multiplier*2);
                  }
              }
          }
        }
    }
}


// Tooth profile modules

module MXL() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-0.660421, -0.5],[-0.660421, 0],[-0.621898, 0.006033],[-0.587714, 0.023037],[-0.560056, 0.049424],[-0.541182, 0.083609],[-0.417357, 0.424392],[-0.398413, 0.458752],[-0.370649, 0.48514],[-0.336324, 0.502074],[-0.297744, 0.508035],[0.297744, 0.508035],[0.336268, 0.502074],[0.370452, 0.48514],[0.39811, 0.458752],[0.416983, 0.424392],[0.540808, 0.083609],[0.559752, 0.049424],[0.587516, 0.023037],[0.621841, 0.006033],[0.660421, 0],[0.660421, -0.5]]);
}

module 40DP() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-0.612775, -0.5],[-0.612775, 0],[-0.574719, 0.010187],[-0.546453, 0.0381],[-0.355953, 0.3683],[-0.327604, 0.405408],[-0.291086, 0.433388],[-0.248548, 0.451049],[-0.202142, 0.4572],[0.202494, 0.4572],[0.248653, 0.451049],[0.291042, 0.433388],[0.327609, 0.405408],[0.356306, 0.3683],[0.546806, 0.0381],[0.574499, 0.010187],[0.612775, 0],[0.612775, -0.5]]);
}

module XL() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-1.525411, -1],[-1.525411, 0],[-1.41777, 0.015495],[-1.320712, 0.059664],[-1.239661, 0.129034],[-1.180042, 0.220133],[-0.793044, 1.050219],[-0.733574, 1.141021],[-0.652507, 1.210425],[-0.555366, 1.254759],[-0.447675, 1.270353],[0.447675, 1.270353],[0.555366, 1.254759],[0.652507, 1.210425],[0.733574, 1.141021],[0.793044, 1.050219],[1.180042, 0.220133],[1.239711, 0.129034],[1.320844, 0.059664],[1.417919, 0.015495],[1.525411, 0],[1.525411, -1]]);
}

module H() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-2.6797, -1],[-2.6797, 0],[-2.600907, 0.006138],[-2.525342, 0.024024],[-2.45412, 0.052881],[-2.388351, 0.091909],[-2.329145, 0.140328],[-2.277614, 0.197358],[-2.234875, 0.262205],[-2.202032, 0.334091],[-1.75224, 1.57093],[-1.719538, 1.642815],[-1.676883, 1.707663],[-1.62542, 1.764693],[-1.566256, 1.813112],[-1.500512, 1.85214],[-1.4293, 1.880997],[-1.353742, 1.898883],[-1.274949, 1.905021],[1.275281, 1.905021],[1.354056, 1.898883],[1.429576, 1.880997],[1.500731, 1.85214],[1.566411, 1.813112],[1.625508, 1.764693],[1.676919, 1.707663],[1.719531, 1.642815],[1.752233, 1.57093],[2.20273, 0.334091],[2.235433, 0.262205],[2.278045, 0.197358],[2.329455, 0.140328],[2.388553, 0.091909],[2.454233, 0.052881],[2.525384, 0.024024],[2.600904, 0.006138],[2.6797, 0],[2.6797, -1]]);
}

module T2_5() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-0.839258, -0.5],[-0.839258, 0],[-0.770246, 0.021652],[-0.726369, 0.079022],[-0.529167, 0.620889],[-0.485025, 0.67826],[-0.416278, 0.699911],[0.416278, 0.699911],[0.484849, 0.67826],[0.528814, 0.620889],[0.726369, 0.079022],[0.770114, 0.021652],[0.839258, 0],[0.839258, -0.5]]);
}

module T5() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-1.632126, -0.5],[-1.632126, 0],[-1.568549, 0.004939],[-1.507539, 0.019367],[-1.450023, 0.042686],[-1.396912, 0.074224],[-1.349125, 0.113379],[-1.307581, 0.159508],[-1.273186, 0.211991],[-1.246868, 0.270192],[-1.009802, 0.920362],[-0.983414, 0.978433],[-0.949018, 1.030788],[-0.907524, 1.076798],[-0.859829, 1.115847],[-0.80682, 1.147314],[-0.749402, 1.170562],[-0.688471, 1.184956],[-0.624921, 1.189895],[0.624971, 1.189895],[0.688622, 1.184956],[0.749607, 1.170562],[0.807043, 1.147314],[0.860055, 1.115847],[0.907754, 1.076798],[0.949269, 1.030788],[0.9837, 0.978433],[1.010193, 0.920362],[1.246907, 0.270192],[1.273295, 0.211991],[1.307726, 0.159508],[1.349276, 0.113379],[1.397039, 0.074224],[1.450111, 0.042686],[1.507589, 0.019367],[1.568563, 0.004939],[1.632126, 0],[1.632126, -0.5]]);
}

module T10() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-3.06511, -1],[-3.06511, 0],[-2.971998, 0.007239],[-2.882718, 0.028344],[-2.79859, 0.062396],[-2.720931, 0.108479],[-2.651061, 0.165675],[-2.590298, 0.233065],[-2.539962, 0.309732],[-2.501371, 0.394759],[-1.879071, 2.105025],[-1.840363, 2.190052],[-1.789939, 2.266719],[-1.729114, 2.334109],[-1.659202, 2.391304],[-1.581518, 2.437387],[-1.497376, 2.47144],[-1.408092, 2.492545],[-1.314979, 2.499784],[1.314979, 2.499784],[1.408091, 2.492545],[1.497371, 2.47144],[1.581499, 2.437387],[1.659158, 2.391304],[1.729028, 2.334109],[1.789791, 2.266719],[1.840127, 2.190052],[1.878718, 2.105025],[2.501018, 0.394759],[2.539726, 0.309732],[2.59015, 0.233065],[2.650975, 0.165675],[2.720887, 0.108479],[2.798571, 0.062396],[2.882713, 0.028344],[2.971997, 0.007239],[3.06511, 0],[3.06511, -1]]);
}

module AT5() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-2.134129, -0.75],[-2.134129, 0],[-2.058023, 0.005488],[-1.984595, 0.021547],[-1.914806, 0.047569],[-1.849614, 0.082947],[-1.789978, 0.127073],[-1.736857, 0.179338],[-1.691211, 0.239136],[-1.653999, 0.305859],[-1.349199, 0.959203],[-1.286933, 1.054635],[-1.201914, 1.127346],[-1.099961, 1.173664],[-0.986896, 1.18992],[0.986543, 1.18992],[1.099614, 1.173664],[1.201605, 1.127346],[1.286729, 1.054635],[1.349199, 0.959203],[1.653646, 0.305859],[1.690859, 0.239136],[1.73651, 0.179338],[1.789644, 0.127073],[1.849305, 0.082947],[1.914539, 0.047569],[1.984392, 0.021547],[2.057906, 0.005488],[2.134129, 0],[2.134129, -0.75]]);
}

module HTD_3mm() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-1.135062, -0.5],[-1.135062, 0],[-1.048323, 0.015484],[-0.974284, 0.058517],[-0.919162, 0.123974],[-0.889176, 0.206728],[-0.81721, 0.579614],[-0.800806, 0.653232],[-0.778384, 0.72416],[-0.750244, 0.792137],[-0.716685, 0.856903],[-0.678005, 0.918199],[-0.634505, 0.975764],[-0.586483, 1.029338],[-0.534238, 1.078662],[-0.47807, 1.123476],[-0.418278, 1.16352],[-0.355162, 1.198533],[-0.289019, 1.228257],[-0.22015, 1.25243],[-0.148854, 1.270793],[-0.07543, 1.283087],[-0.000176, 1.28905],[0.075081, 1.283145],[0.148515, 1.270895],[0.219827, 1.252561],[0.288716, 1.228406],[0.354879, 1.19869],[0.418018, 1.163675],[0.477831, 1.123623],[0.534017, 1.078795],[0.586276, 1.029452],[0.634307, 0.975857],[0.677809, 0.91827],[0.716481, 0.856953],[0.750022, 0.792167],[0.778133, 0.724174],[0.800511, 0.653236],[0.816857, 0.579614],[0.888471, 0.206728],[0.919014, 0.123974],[0.974328, 0.058517],[1.048362, 0.015484],[1.135062, 0],[1.135062, -0.5]]);
}

module HTD_5mm() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-1.89036, -0.75],[-1.89036, 0],[-1.741168, 0.02669],[-1.61387, 0.100806],[-1.518984, 0.21342],[-1.467026, 0.3556],[-1.427162, 0.960967],[-1.398568, 1.089602],[-1.359437, 1.213531],[-1.310296, 1.332296],[-1.251672, 1.445441],[-1.184092, 1.552509],[-1.108081, 1.653042],[-1.024167, 1.746585],[-0.932877, 1.832681],[-0.834736, 1.910872],[-0.730271, 1.980701],[-0.62001, 2.041713],[-0.504478, 2.09345],[-0.384202, 2.135455],[-0.259708, 2.167271],[-0.131524, 2.188443],[-0.000176, 2.198511],[0.131296, 2.188504],[0.259588, 2.167387],[0.384174, 2.135616],[0.504527, 2.093648],[0.620123, 2.04194],[0.730433, 1.980949],[0.834934, 1.911132],[0.933097, 1.832945],[1.024398, 1.746846],[1.108311, 1.653291],[1.184308, 1.552736],[1.251865, 1.445639],[1.310455, 1.332457],[1.359552, 1.213647],[1.39863, 1.089664],[1.427162, 0.960967],[1.467026, 0.3556],[1.518984, 0.21342],[1.61387, 0.100806],[1.741168, 0.02669],[1.89036, 0],[1.89036, -0.75]]);
}

module HTD_8mm() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-3.301471, -1],[-3.301471, 0],[-3.16611, 0.012093],[-3.038062, 0.047068],[-2.919646, 0.10297],[-2.813182, 0.177844],[-2.720989, 0.269734],[-2.645387, 0.376684],[-2.588694, 0.496739],[-2.553229, 0.627944],[-2.460801, 1.470025],[-2.411413, 1.691917],[-2.343887, 1.905691],[-2.259126, 2.110563],[-2.158035, 2.30575],[-2.041518, 2.490467],[-1.910478, 2.66393],[-1.76582, 2.825356],[-1.608446, 2.973961],[-1.439261, 3.10896],[-1.259169, 3.22957],[-1.069074, 3.335006],[-0.869878, 3.424485],[-0.662487, 3.497224],[-0.447804, 3.552437],[-0.226732, 3.589341],[-0.000176, 3.607153],[0.226511, 3.589461],[0.447712, 3.552654],[0.66252, 3.497516],[0.870027, 3.424833],[1.069329, 3.33539],[1.259517, 3.229973],[1.439687, 3.109367],[1.608931, 2.974358],[1.766344, 2.825731],[1.911018, 2.664271],[2.042047, 2.490765],[2.158526, 2.305998],[2.259547, 2.110755],[2.344204, 1.905821],[2.411591, 1.691983],[2.460801, 1.470025],[2.553229, 0.627944],[2.588592, 0.496739],[2.645238, 0.376684],[2.720834, 0.269734],[2.81305, 0.177844],[2.919553, 0.10297],[3.038012, 0.047068],[3.166095, 0.012093],[3.301471, 0],[3.301471, -1]]);
}

module GT2_2mm() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[0.747183, -0.5],[0.747183, 0],[0.647876, 0.037218],[0.598311, 0.130528],[0.578556, 0.238423],[0.547158, 0.343077],[0.504649, 0.443762],[0.451556, 0.53975],[0.358229, 0.636924],[0.2484, 0.707276],[0.127259, 0.750044],[0, 0.76447],[-0.127259, 0.750044],[-0.2484, 0.707276],[-0.358229, 0.636924],[-0.451556, 0.53975],[-0.504797, 0.443762],[-0.547291, 0.343077],[-0.578605, 0.238423],[-0.598311, 0.130528],[-0.648009, 0.037218],[-0.747183, 0],[-0.747183, -0.5]]);
}

module GT2_3mm() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-1.155171, -0.5],[-1.155171, 0],[-1.065317, 0.016448],[-0.989057, 0.062001],[-0.93297, 0.130969],[-0.90364, 0.217664],[-0.863705, 0.408181],[-0.800056, 0.591388],[-0.713587, 0.765004],[-0.60519, 0.926747],[-0.469751, 1.032548],[-0.320719, 1.108119],[-0.162625, 1.153462],[0, 1.168577],[0.162625, 1.153462],[0.320719, 1.108119],[0.469751, 1.032548],[0.60519, 0.926747],[0.713587, 0.765004],[0.800056, 0.591388],[0.863705, 0.408181],[0.90364, 0.217664],[0.932921, 0.130969],[0.988924, 0.062001],[1.065168, 0.016448],[1.155171, 0],[1.155171, -0.5]]);
}

module GT2_5mm() {
    linear_extrude(height=toothed_part_length+2)
      polygon([[-1.975908, -0.75],[-1.975908, 0],[-1.797959, 0.03212],[-1.646634, 0.121224],[-1.534534, 0.256431],[-1.474258, 0.426861],[-1.446911, 0.570808],[-1.411774, 0.712722],[-1.368964, 0.852287],[-1.318597, 0.989189],[-1.260788, 1.123115],[-1.195654, 1.25375],[-1.12331, 1.380781],[-1.043869, 1.503892],[-0.935264, 1.612278],[-0.817959, 1.706414],[-0.693181, 1.786237],[-0.562151, 1.851687],[-0.426095, 1.9027],[-0.286235, 1.939214],[-0.143795, 1.961168],[0, 1.9685],[0.143796, 1.961168],[0.286235, 1.939214],[0.426095, 1.9027],[0.562151, 1.851687],[0.693181, 1.786237],[0.817959, 1.706414],[0.935263, 1.612278],[1.043869, 1.503892],[1.123207, 1.380781],[1.195509, 1.25375],[1.26065, 1.123115],[1.318507, 0.989189],[1.368956, 0.852287],[1.411872, 0.712722],[1.447132, 0.570808],[1.474611, 0.426861],[1.534583, 0.256431],[1.646678, 0.121223],[1.798064, 0.03212],[1.975908, 0],[1.975908, -0.75]]);
}
