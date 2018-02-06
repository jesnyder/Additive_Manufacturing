// Original: February 6, 2018 
// Description: Model of a 1.0 mL tube with a cap, as measured using a ruler.  
// Purpose: As containment vessel to test cellular toxicity
// All measurements in millimeters 

// Quality 
fn_quality = 200; 

// Tube geometry 
tube_wall_width = 1; 
tube_barrel_width = 10/2; 
cone_length = 20; 
tube_length = 35; 

// Cap geometry 
cap_outer_width = 3/2*tube_barrel_width;
cap_outer_lip = 3;
distance_lid_to_tube = 25; 

// Connector geometry 
connector_width = 4; 
connector_thickness = .5; 

// Revolve tube 
rotate_extrude($fn=fn_quality) 
polygon( points=[[0,0],[2*tube_wall_width,0],[tube_barrel_width,cone_length],[tube_barrel_width,tube_length],[tube_barrel_width+1,tube_length],[tube_barrel_width+1,tube_length+2*tube_wall_width],[tube_barrel_width-tube_wall_width,tube_length+2*tube_wall_width],[tube_barrel_width-tube_wall_width,cone_length],[0,2*tube_wall_width]] );

// Revolve cap 
translate([0,distance_lid_to_tube,tube_length+1])
rotate_extrude($fn=fn_quality) 
polygon( points=[[0,0],[cap_outer_width,0],[cap_outer_width,2],[cap_outer_width-cap_outer_lip,2],[cap_outer_width-cap_outer_lip,7],[tube_barrel_width-tube_wall_width,7],[tube_barrel_width-tube_wall_width,2],[0,2]] );

// Connector between cap and tube, an extruded rectangle
translate([-connector_width/2,tube_barrel_width-1,tube_length+1.5])
linear_extrude(height = connector_thickness, center = true, $fn=fn_quality) 
polygon( points=[[0,0],[connector_width,0],[connector_width,distance_lid_to_tube],[0,distance_lid_to_tube]] );
