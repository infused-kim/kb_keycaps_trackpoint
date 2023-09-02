use <stl_combiner.scad>

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
    avg_y = -key_stagger / 2;
    translate([0, avg_y, 0])
        cylinder($fn=60, d=d, h=h, center=true);
}

module draw_keycap(keycap_arr,
                   offset_x,
                   offset_y,) {

    stl_path = keycap_arr[0];
    translation = keycap_arr[1];
    rotation = keycap_arr[2];
    mirroring = keycap_arr[3];

    translate([offset_x, offset_y, 0])
        rotate(rotation)
            mirror(mirroring)
                translate(translation)
                    import(stl_path);
}

module draw_keycaps(keycap_top_left,
                    keycap_top_right,
                    keycap_bottom_left,
                    keycap_bottom_right,
                    output,
                    offset_x,
                    offset_y,
                    stagger,
                    adjustment) {

    if(output == "top_left" || output == "preview")
        draw_keycap(keycap_top_left, -offset_x, +offset_y - stagger);
    if(output == "top_right" || output == "preview")
        draw_keycap(keycap_top_right, +offset_x, +offset_y);
    if(output == "bottom_left" || output == "preview")
        draw_keycap(keycap_bottom_left, -offset_x, -offset_y - stagger);
    if(output == "bottom_right" || output == "preview")
        draw_keycap(keycap_bottom_right, +offset_x, -offset_y);
}


module _cut_keycaps(keycap_top_left,
                    keycap_top_right,
                    keycap_bottom_left,
                    keycap_bottom_right,
                    output,
                    key_profile,
                    key_stagger,
                    key_spread_x,
                    key_spread_y,
                    tp_diameter,
                    tp_height,
                    debug=false) {

    // If alternative that avoids inability to assign values in if statments
    key_offset_x = (
        key_profile == "mx"
            ? key_spread_mx_x / 2
        : key_profile == "choc"
            ? key_spread_choc_x / 2
        : // else
            key_spread_x / 2
    );

    key_offset_y = (
        key_profile == "mx"
            ? key_spread_mx_y / 2
        : key_profile == "choc"
            ? key_spread_choc_y / 2
        : // else
            key_spread_y / 2
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

    stagger_val = key_stagger == "corne" ? 2.375 : key_stagger;

    // If we are exporting individual keys, we want re-center them
    // around origin to make sprueing easy.
    origin_move = (
        output == "top_left"
            ? [+key_offset_x, -key_offset_y + stagger_val, 0]
        : output == "top_right"
            ? [-key_offset_x, -key_offset_y, 0]
        : output == "bottom_left"
            ? [+key_offset_x, +key_offset_y + stagger_val, 0]
        : output == "bottom_right"
            ? [-key_offset_x, +key_offset_y, 0]
        : //else
            [0, 0, 0]
    );

    translate(origin_move)
        difference() {
            draw_keycaps(
                keycap_top_left, keycap_top_right,
                keycap_bottom_left, keycap_bottom_right,
                output,
                key_offset_x, key_offset_y, stagger_val
            );
            draw_trackpoint(tp_diameter, tp_height, stagger_val);
        }

    if(debug == true) {
        translate(origin_move)
            draw_trackpoint(tp_diameter, tp_height, stagger_val);
    }
}

module gen_sprued_keycaps(keycap_top_left,
                          keycap_top_right,
                          keycap_bottom_left,
                          keycap_bottom_right,
                          key_profile,
                          key_stagger,
                          key_spread_x,
                          key_spread_y,
                          tp_diameter,
                          tp_height,
                          debug=false) {

    outputs = ["top_left", "top_right", "bottom_left", "bottom_right"];
    sprue_spacing = (
        key_profile == "mx"
            ? key_spread_mx_x
        : key_profile == "choc"
            ? key_spread_choc_x
        : // else
            key_spread_x
    );

    union() {
        for (i = [0 : len(outputs) - 1]) {
            output = outputs[i];
            translate([i * sprue_spacing, 0, 0])

                _cut_keycaps(
                    keycap_top_left,
                    keycap_top_right,
                    keycap_bottom_left,
                    keycap_bottom_right,
                    output,
                    key_profile,
                    key_stagger,
                    key_spread_x,
                    key_spread_y,
                    tp_diameter,
                    tp_height,
                    debug
                );
        }

        gen_sprues(len(outputs) - 1);
    };
}

module cut_keycaps(keycap_top_left,
                   keycap_top_right,
                   keycap_bottom_left,
                   keycap_bottom_right,
                   output,
                   key_profile,
                   key_stagger,
                   key_spread_x,
                   key_spread_y,
                   tp_diameter,
                   tp_height,
                   debug=false) {

    if(output == "sprued") {
        gen_sprued_keycaps(
            keycap_top_left,
            keycap_top_right,
            keycap_bottom_left,
            keycap_bottom_right,
            key_profile,
            key_stagger,
            key_spread_x,
            key_spread_y,
            tp_diameter,
            tp_height,
            debug
        );
    } else {
        _cut_keycaps(
            keycap_top_left,
            keycap_top_right,
            keycap_bottom_left,
            keycap_bottom_right,
            output,
            key_profile,
            key_stagger,
            key_spread_x,
            key_spread_y,
            tp_diameter,
            tp_height,
            debug
        );
    }
}
