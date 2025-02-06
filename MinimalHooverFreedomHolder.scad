///////////////////////////////////
// Minimal Hoover Freedom Holder //
//      by  left2repairLIVE      //
///////////////////////////////////




$fn = 128;

backwallStrength = 5.66;
holderWidth = 22.22;

hookStrength = 4.00;
hookDepth = 15.26;
hookSpacing = 18.09;

connectorWedgeDepth = 36.00 - hookStrength;
connectorWedgeHeight = hookStrength + hookSpacing;

fullHookDepth = connectorWedgeDepth + hookStrength + hookDepth;

backwallPadding = 20;

screwDiameter = 5.66;
screwHeadDiameter = 11.12;
screwHeadHeight = 2.9;



backwallDimensions = [holderWidth, backwallPadding * 2 + fullHookDepth, backwallStrength];

connectorWedgePoints = 
[
    [0, 0],
    [0, connectorWedgeDepth],
    [connectorWedgeHeight, connectorWedgeDepth]
];

hookSupportDimensions = [holderWidth, hookStrength, hookSpacing + hookStrength];
hookSupportTranslation = [0, backwallPadding + connectorWedgeDepth, backwallStrength];

hookDimensions = [holderWidth, hookDepth, hookStrength];
hookTranslation = [0, backwallPadding + connectorWedgeDepth + hookStrength, backwallStrength + hookSpacing];

nearScrewHoleTranslation = [holderWidth / 2, backwallPadding / 2, 0];
farScrewHoleTranslation = [backwallDimensions[0] - nearScrewHoleTranslation[0], backwallDimensions[1] - nearScrewHoleTranslation[1], 0];


difference()
{
    union()
    {
        // backwall
        cube(backwallDimensions);


        // connector wedge
        translate([holderWidth,backwallPadding, backwallStrength]) rotate([0, -90, 0])
            linear_extrude(holderWidth)
                polygon(connectorWedgePoints);

        
        // hook support
        translate(hookSupportTranslation)
            cube(hookSupportDimensions);

        // hook
        translate(hookTranslation)
            cube(hookDimensions);
    }

    // near screw hole
    translate(nearScrewHoleTranslation)
        screwHole();

    // far screw hole
    translate(farScrewHoleTranslation)
        screwHole();
}




module screwHole()
{
    cylinder(d = screwDiameter, h = backwallStrength);

    translate([0, 0, backwallStrength - screwHeadHeight])
        cylinder(d1 = screwDiameter, d2 = screwHeadDiameter, screwHeadHeight);
}