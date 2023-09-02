output = "preview";

key_profile = "choc"; // choc"../keycaps/mbk/mbk_keycap_1u.stl"mx or custom while setting key_spread_x and y
key_stagger = -2.375;

// Set key_profile to "custom" and then these two parameters if you
// want to use a custom distance between keycaps
key_spread_x = 0;
key_spread_y = 0;

tp_diameter = 9.5; // Most Lenovo trackpoints are 8.5mm wide
tp_height = 14;

// Set to true to draw the trackpoint
debug = false;

use <keycap_cutter.scad>

// Keycap array: stl path, translate adjustment, rotation, mirror
mbk_1u = ["../keycaps/mbk/mbk_keycap_1u.stl", [0, 0, 0], [0, 0, 0], [0, 0, 0]];
mbk_1u_homing = ["../keycaps/mbk/mbk_keycap_1u_homing.stl", [23, 0, 0], [0, 0, 0], [0, 0, 0]];

cut_keycaps(
    keycap_top_left=mbk_1u,
    keycap_top_right=mbk_1u,
    keycap_bottom_left=mbk_1u,
    keycap_bottom_right=mbk_1u_homing,
    output,
    key_profile,
    key_stagger,
    key_spread_x,
    key_spread_y,
    tp_diameter,
    tp_height,
    debug
);
