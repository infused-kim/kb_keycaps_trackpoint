output = "preview";

key_profile = "choc"; // choc, mx or custom while setting key_spread_x and y
key_stagger = "corne"; // Change to numerical value to customize

// Set key_profile to "custom" and then these two parameters if you
// want to use a custom distance between keycaps
key_spread_x = 0;
key_spread_y = 0;

tp_diameter = 9.5; // Most Lenovo trackpoints are 8.5mm wide
tp_height = 14;

// Set to true to draw the trackpoint
debug = false;

use <keycap_cutter.scad>
include <cs_keys.scad>

cut_keycaps(
   keycap_top_left=cs_r3,
   keycap_top_right=cs_r3,
   keycap_bottom_left=cs_r3,
   keycap_bottom_right=cs_r3_dot,
   output,
   key_profile,
   key_stagger,
   key_spread_x,
   key_spread_y,
   tp_diameter,
   tp_height,
   debug
);
