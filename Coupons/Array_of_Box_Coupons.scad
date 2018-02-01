// Title: Box coupons to test material formability with a 3D printer 

// All measurement in millimeters, mm

// Height of the base
h_base = 1; 

// Spacing and patterning of each coupon
num_of_row = 12; //  12 
num_of_col = 8; // 8

// Maximum radius and height of the each cylindrical coupon
r_well = 2*1.5; // 1.5
h_well = 8;  // 8
center_to_center = r_well*2+.25; 
quality_fn = 10; // 10 for prototyping, 50 for final quality

// Build an array of boxes with desired out diameter 
module box_array_outer() {   
    for(j=[1:num_of_row]) {  
    for(i=[1:num_of_col]) {  
        translate([i*center_to_center, j*center_to_center, 0]) 
        cube (size = [r_well*j/num_of_row, r_well*j/num_of_row, h_well], $fn=quality_fn);
     }}}

// Build an array of boxes to later be subtracted
module box_array_inner() {   
    for(j=[1:num_of_row]) {  
    for(i=[1:num_of_col]) {  
        translate([i*center_to_center+r_well*j/num_of_row/2, j*center_to_center+r_well*j/num_of_row/2, -h_well]) 
        cube (size = [r_well*j/num_of_row*i/num_of_col, r_well*j/num_of_row*i/num_of_col, 10*h_well], $fn=quality_fn);

     }}}
  
 // Build the cylinder array on a solid base
 module box_array_with_base() {    
    union(){
        cube([(num_of_col+.5)*center_to_center, (num_of_row+.5)*center_to_center, h_base]);
        box_array_outer ();
    } }
 
// Create hollow tubes  
difference(){
    box_array_with_base();
    box_array_inner();
 }
    
   