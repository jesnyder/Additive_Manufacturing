// April 23, 2018 
// Build a series of protrusions to mold holes in PDMS
// All measurement in millimeters

// Cell-PDMS attachment: https://gmwgroup.harvard.edu/pubs/pdf/891.pdf


wellDiameter = 1; wellDepth = 2; spacing = wellDiameter*.4;// Parameters of each protrusions, to be molded to form wells
rows = 5; columns = 8; // Array parametes of the protrusion pattern


baseLength = wellDiameter*(2+spacing)*(columns+1); 
baseWidth = wellDiameter*(2+spacing)*(rows+1); 
baseHeight = wellDepth+2; 

module plate(baseLength, baseWidth, baseHeight){
    innerPlate = [baseLength, baseWidth, 2*baseHeight];
    outerPlate = [1.2*baseLength, 1.2*baseWidth, 2*baseHeight];
    difference(){ 
        translate([0, 0, -baseHeight]) cube(outerPlate,true); 
        translate([0, 0, -baseHeight+3]) cube(innerPlate,true); } // difference ended
    } // module ended

module wells4cells (wellDiameter, wellDepth,rows,columns){
    $fn = 40;
    translate([-wellDiameter*columns*(1+spacing), -wellDiameter*rows*(1+spacing), 0])
    union(){
    for(j = [1 : 1 : rows]) {
        for(i = [1 : 1 : columns]) {
            translate([i*(2+spacing)*wellDiameter,j*(2+spacing)*wellDiameter,wellDepth/2])
            cylinder(h = wellDepth, r1 = wellDiameter, r2 = wellDiameter, center = true);
            }   // for loop ends
        } // for loop ends 
    } // union ends
    } // module ended
 
    
 union(){  
    wells4cells(wellDiameter, wellDepth,rows,columns);  
    translate([0, 0, baseHeight]) plate(baseLength, baseWidth, baseHeight);
 } // end union
      