output = "preview";

keycap_top_left  = "../keycaps/mbk/mbk_keycap_1u.stl";
keycap_top_right  = "../keycaps/mbk/mbk_keycap_1u.stl";
keycap_bottom_left  = "../keycaps/mbk/mbk_keycap_1u.stl";
keycap_bottom_right  = "../keycaps/mbk/mbk_keycap_1u.stl";

key_profile = "choc"; // choc, mx or custom while setting key_spread_x and y
key_stagger = -2.375;
key_spread_x = 0;
key_spread_y = 0;

tp_diameter = 9.5; //  Most Lenovo trackpoints are 8.5mm wide
tp_height = 14;

key_spread_choc_x = 18;
key_spread_choc_y = 17;
key_spread_mx_x = 19;
key_spread_mx_y = 19;


module draw_trackpoint(d, h, key_stagger) {

    // We are using the same method for determining where to place the
    // trackpoint as ergogen's "average point aggregator method", which
    // adds up the x and y value of all 4 keys and then divides them by 4
    // Example:
    //  x: left_top_x + left_bottom_x + right_top_x + right_bottom_x / 4
    //  x: 19 + -19 + 19 + -19 = 0 / 4 = 0
    //
    // y: left_top_y+stagger + left_bottom_y+stagger + right_top_y + right_bottom_y / 4
    // y: 19-2.375 + -19-2.375 + 19 + -19 = -4.75 / 4 = -1.1875
    //
    // Since the key positions always balance each other out, x is always 0
    // And for y we only need to divide the key_stagger by 2
    avg_y = key_stagger / 2;
    translate([0, avg_y, 0])
        cylinder($fn=60, d=d, h=h, center=true);
}

module draw_keycap(stl_path, offset_x=0, offset_y=0, should_mirror=false, rotation=0) {
    m = should_mirror ? [0, 1, 0] : [0, 0, 0];

    translate([offset_x, offset_y, 0])
        rotate([0, rotation, 0])
            mirror(m)
                import(stl_path);
}

module draw_keycaps(offset_x, offset_y, stagger, output) {

    if(output == "top_left" || output == "preview")
        draw_keycap(keycap_top_left, -offset_x, +offset_y + stagger);
    if(output == "top_right" || output == "preview")
        draw_keycap(keycap_top_right, +offset_x, +offset_y);
    if(output == "bottom_left" || output == "preview")
        draw_keycap(keycap_bottom_left, -offset_x, -offset_y + stagger);
    if(output == "bottom_right" || output == "preview")
        draw_keycap(keycap_bottom_right, +offset_x, -offset_y);
}


module main() {


    // If alternative that avoids inability to assign values in if statments
    key_offset_x = (
        key_profile == "mx"
        ? key_spread_mx_x / 2
        : key_profile == "choc"
            ? key_spread_choc_x / 2 :  key_spread_x / 2
    );

    key_offset_y = (
        key_profile == "mx"
        ? key_spread_mx_y / 2
        : key_profile == "choc"
            ? key_spread_choc_y / 2 :  key_spread_y / 2
    );

    if(key_profile != "mx" &&
       key_profile != "choc" &&
       key_profile != "custom") {
        assert(false, str("Unknown key profile selected '", key_profile, "'. Allowed options are 'mx', 'choc' and 'custom' with key_spread_x and y."));
    }

    if(output != "top_left" &&
       output != "top_right" &&
       output != "bottom_left" &&
       output != "bottom_right" &&
       output != "preview") {
        assert(false, str("Unknown output selected '", output, "'. Allowed options are 'preview', 'top_left', 'top_right', 'bottom_left' and 'bottom_right'."));

    }

    difference() {
        draw_keycaps(key_offset_x, key_offset_y, key_stagger, output);
        draw_trackpoint(tp_diameter, tp_height, key_stagger);
    }

}

main();
