output = "preview";

key_profile = "choc"; // choc, mx or custom while setting key_spread_x and y
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
cs_r2_top = [
   "../keycaps/chicago_steno/cs_r2_1.stl",
   [0, 18, 0], [0, 0, 180], [0, 0, 0]
];
cs_r3 = [
   "../keycaps/chicago_steno/cs_r3_1.stl",
   [0, 18, 0], [0, 0, 0], [0, 0, 0]
];
cs_r3_bar = [
   "../keycaps/chicago_steno/cs_r3_1_bar.stl",
   [0, 18, 0], [0, 0, 0], [0, 0, 0]
];

cut_keycaps(
   keycap_top_left=cs_r2_top,
   keycap_top_right=cs_r2_top,
   keycap_bottom_left=cs_r3,
   keycap_bottom_right=cs_r3_bar,
   output,
   key_profile,
   key_stagger,
   key_spread_x,
   key_spread_y,
   tp_diameter,
   tp_height,
   debug
);