// the thickness of the lines as as seen from above
thickness = 5;

// how high it will protrude from the build plate
width = 10;

// the length of the part that goes behind the wall
length = 50;

// the wall thickness. It doesn't have to be a cubicle ;)
cubicle = 20;

// how far it goes down before the roundness starts
hang = 20;

// the inner width of the half-circle part of the hook
gap = 10;

// vertical part above the hook to prevent slipping off
tip = 5;

module hook() {
  union() {
    // make the part behind the wall
    cube([thickness, width, length]);

    // the part above the wall
    translate([thickness, 0, length-thickness])
    cube([cubicle, width, thickness]);

    // the part that goes down to the hook
    translate([cubicle+thickness, 0, length-hang])
    cube([thickness, width, hang]);

    // the round part of the hook
    difference() {
      // a big cylinder
      translate([thickness*2+cubicle+gap/2, 0, length-hang])
      rotate([270, 0, 0])
      cylinder(h=width, d=gap+2*thickness);

      // minus a smaller cylinder
      translate([cubicle+thickness*2+gap/2, -0.1, length-hang])
      rotate([270, 0, 0])
      cylinder(h=width+0.2, d=gap);

      // minus a cube to turn it into a semicircle
      translate([cubicle+thickness, -0.1, length-hang])
      cube([gap+2*thickness, width+0.2, gap+2*thickness]);
    }

    // add a vertical tip above the hook
    translate([cubicle+thickness*2+gap, 0, length-hang])
    cube([thickness, width, tip]);
  }
}

// TIP: don't translate/rotate and then you can see it in the orientation it
// will be used.
translate([0, length, 0])
rotate([90, 0, 0])
hook();
