// Title: Cylindrical coupons to test material formability with a 3D printer 

// All measurement in millimeters, mm

// Height of the dish
h_base = 1; 

// Spacing and patterning of each cyllindrical coupon
num_of_row = 12;
num_of_col = 8;

// Maximum radius and height of the each cylindrical coupon
r_well = 1.5; 
h_well = 8; 
center_to_center = r_well*2+.25;
quality_fn = 50;

// Build an array of cylinders with final outer diamter
module cylinder_array_outer() {   
    for(j=[1:num_of_row]) {  
    for(i=[1:num_of_col]) {  
        translate([i*center_to_center, j*center_to_center, 0]) 
        cylinder (h = h_well, r=j/num_of_row*r_well, $fn=quality_fn);
     }}}

// Build an array of cylinders to later be subtracted
module cylinder_array_inner() {   
    for(j=[1:num_of_row]) {  
    for(i=[1:num_of_col]) {  
        translate([i*center_to_center, j*center_to_center, -h_well]) 
        cylinder (h = 3*h_well, r=(1-i/num_of_col)*j/num_of_row*r_well, $fn=quality_fn); 
     }}}
  
 // Build the cylinder array on a solid base
 module cylindrical_array_with_base() {    
    union(){
        cube([(num_of_col+.5)*center_to_center, (num_of_row+.5)*center_to_center, h_base]);
        cylinder_array_outer ();
    } }
 
// Create hollow tubes  
 difference(){
    cylindrical_array_with_base();
    cylinder_array_inner();
 }
    
   