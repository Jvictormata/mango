$fn = 40;

module pin() {
  h1 = 0.46;
  h2 = 2.3;
  h3 = 0.975;
  h4 = 0.6;
  h5 = 0.81;
  h6 = 2.1;

  difference() {

    union() {
      cylinder(h1, r=5.59 / 2);
      translate([0, 0, h1]) {
        cylinder(h2, r1=5.59 / 2, r2=3.3 / 2);
        translate([0, 0, h2]) {
          cylinder(h3, r=3.5 / 2);
          translate([0, 0, h3]) {
            cylinder(h4, r=2.2 / 2);
            translate([0, 0, h4]) {
              cylinder(h5, r1=2.2 / 2, r2=3.0 / 2);
              translate([0, 0, h5]) {
                cylinder(h6, r1=3.0 / 2, r2=1.7 / 2);
              }
            }
          }
        }
      }
    }
  
    translate([0, 0, h1 + h2 + h3 + h4 + h5 + 1e-3])
    cylinder(r=0.7 / 2, h=h6);
    
  }
}


module hole() {
  translate([0, 0, -0.5e-3])
  cylinder(r=3 / 2, h=6.5 + 1e-3);
  translate([0, 0, 6.01])
  cylinder(r1 = 3 / 2, r2=3 / 2 + 0.5, h=0.5);
}


module frame() {
translate([0.0000, -0.0000, 6.5000]) {
  pin();
}translate([16.1500, -25.2800, 6.5000]) {
  pin();
}translate([65.0000, -0.0000, 6.5000]) {
  pin();
}translate([29.6100, 18.6500, 6.5000]) {
  pin();
}
union() {
  
  hull() {
    translate([0.0000, -0.0000, 0.0000]) {
      union() {
        cylinder(h=6.0, r1=4.7, r2=4.7, $fn=40);
        translate([0.0000, 0.0000, 6.0000]) {
          cylinder(h=0.5, r1=4.7, r2=4.2, $fn=40);
        }
      }
    }
    translate([65.0000, -0.0000, 0.0000]) {
      union() {
        cylinder(h=6.0, r1=4.7, r2=4.7, $fn=40);
        translate([0.0000, 0.0000, 6.0000]) {
          cylinder(h=0.5, r1=4.7, r2=4.2, $fn=40);
        }
      }
    }
  }
  
  
  hull() {
    translate([16.1500, -25.2800, 0.0000]) {
      union() {
        cylinder(h=6.0, r1=4.7, r2=4.7, $fn=40);
        translate([0.0000, 0.0000, 6.0000]) {
          cylinder(h=0.5, r1=4.7, r2=4.2, $fn=40);
        }
      }
    }
    translate([29.6100, 18.6500, 0.0000]) {
      union() {
        cylinder(h=6.0, r1=4.7, r2=4.7, $fn=40);
        translate([0.0000, 0.0000, 6.0000]) {
          cylinder(h=0.5, r1=4.7, r2=4.2, $fn=40);
        }
      }
    }
  }
}
}


module chamfered_cube(vec, chamfer=1) {
  hull() {
    translate([0, chamfer, chamfer])
    cube([vec[0], vec[1] - chamfer * 2, vec[2] - chamfer * 2]);
  
    translate([chamfer, 0, chamfer])
    cube([vec[0] - chamfer * 2, vec[1], vec[2] - chamfer * 2]);
  
    translate([chamfer, chamfer, 0])
    cube([vec[0] - chamfer * 2, vec[1] - chamfer * 2, vec[2]]);
  }
}

$fn=40;

wall = 2;
h = 10;

module clip() {
  difference() {
    chamfered_cube([12 + 2 * wall, 18 + 4, h]);
    translate([wall, -1e-3, -.5e-3])
    cube([12, 18 + 0.1 + 1e-3, h + 1e-3]); 
  }

  translate([0, 0, 0])
  chamfered_cube([4, 3.5, h], chamfer=1);

  translate([12, 0, 0])
  chamfered_cube([4, 3.5, h]);
}

module clip_with_hole() {
  difference() {
    clip();
    
    translate([(11 + 2 * wall) / 2, 18 + 2, h / 2])
    rotate([90, 0, 0])
    cylinder(r=6/2 + 0.1, h=2);
    
    translate([(11 + 2 * wall) / 2, 18 + 5, h / 2])
    rotate([90, 0, 0])
    cylinder(r=1.5 / 2, h=wall + 2);
  }
}

translate([60, -3, 0])
chamfered_cube([60, 6, 6.5]);

translate([98, 6 + wall, 6])
rotate([0, 0, -90])
clip_with_hole();


difference() {
    frame();
    
        translate([8, 0, 0])
    hole();
    
    translate([16, 0, 0])
    hole();
    
    translate([24, 0, 0])
    hole();
    
        translate([32, 0, 0])
    hole();
    
        translate([40, 0, 0])
    hole();
    
        translate([48, 0, 0])
    hole();
    
        translate([56, 0, 0])
    hole();
}