/* Electric Fence Wire Support
    Author:  Tom Clupper
    Date: 6/30/2020
    License: Attribution-ShareAlike 4.0 International (https://creativecommons.org/licenses/by-sa/4.0)
    
    NOTES:
    - Use this desgin at your own risk.  There is no guarantee that it will work for you.    
    - No supports needed
    - Use a plastic material that will withstand the temperatures and weather conditions outdoors
    - Is attached using a standard 1-1/4 inch long #10 machine screw and nut.  The nut will be held in place.
    - The wire is held in the slot using a standard 3/16 inch wide plastic wire tie (0.053 inch thick)
*/

// A couple of constants (need to end up in mm)
mm = 1.0;
cm = 10.0;
inches = 25.4;
inch = 25.4;
mils = 25.4/1000.0;

// Define some variables
ST = 1.4*inch;      // Support thickness
PBD = 100*mm;       // Print bed diameter
n = 8;              // Number of sides to support
SW = 80*mm;         // Support width
Angle = 45;          // Support angle (0 to 50 degrees)
WD = 0.070*inches;   // Wire diameter


translate([0,0,ST/2]) {    
   difference(){
    union(){
      intersection(){
        rotate([0,0,Angle]){
          difference(){
            // Support stem  
            translate([-PBD/4,0,0]) cube([PBD/2+PBD/2, 0.5*inches,ST], center=true);
            // Slot for wire    
            translate([-PBD/2,0,0]) cube([30*mm, WD, ST], center=true);
            // Holes for wire (if you need to tie it off)
            translate([-PBD/2+2.5*WD,0,ST/2-2.5*WD]) rotate([90,0,0]) cylinder(h=1.5*inch, d=1.8*WD, center=true, $fn=20); 
            translate([-PBD/2+2.5*WD,0,-(ST/2-2.5*WD)]) rotate([90,0,0]) cylinder(h=1.5*inch, d=1.8*WD, center=true, $fn=20);
            // Slot for plastic strap (to hold sire in slot) 
            translate([-PBD/2+4.5,0,0]) cube([0.075*inch,1.5*inch,0.21*inch], center=true);  
          } 
        }
        // Clip off the bed diameter
        cylinder(h=ST,d=PBD,center=true, $fn=60);             
      }
      // The base
      translate([0,0,-ST/2]) cube([1*inch,1*inch,ST]);     
    }
    union(){
      translate([PBD/3.2,0,0]) rotate([0,0,90]) rotate([0,90,0]) rotate([0,0,360/(2*n)]) cylinder(h=PBD/2+PBD/2,r=0.63*inches, center=true, $fn=n);
      translate([PBD/4,0,0]) rotate([0,0,90]) rotate([0,90,0]) rotate([0,0,360/(2*n)]) cylinder(h=PBD/2+PBD/2,r=0.5*inches, center=true, $fn=30);
    // #10 screw relief
      #translate([0,0.35*inches,0]) rotate([0,90,0]) cylinder(h=PBD,d=5*mm, center=true, $fn=30);
      #translate([-0.1*inches,0.35*inches,0]) rotate([0,90,0]) cylinder(h=0.4*inches,d=10*mm, center=true, $fn=30);     
    }
  }
}
