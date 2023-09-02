
key_stagger = "corne";
key_profile = "choc";

variation = str(key_profile, "_", key_stagger);

keycaps = [
   // R2 top left and right
   str("../stl/cs_r2_r3_homing_bar/cs_r2_r3_homing_bar_", variation, "_top_left.stl"),
   str("../stl/cs_r2_r3_homing_bar/cs_r2_r3_homing_bar_", variation, "_top_right.stl"),

   // R3 bottom left
   str("../stl/cs_r2_r3_homing_bar/cs_r2_r3_homing_bar_", variation, "_bottom_left.stl"),

   // R3 bottom homing bar
   str("../stl/cs_r2_r3_homing_bar/cs_r2_r3_homing_bar_", variation, "_bottom_right.stl"),

   // R3 bottom homing dot
   str("../stl/cs_r2_r3_homing_dot/cs_r2_r3_homing_dot_", variation, "_bottom_right.stl"),

   // R3 Top left and right
   str("../stl/cs_r3_r3_homing_bar/cs_r3_r3_homing_bar_", variation, "_top_left.stl"),
   str("../stl/cs_r3_r3_homing_bar/cs_r3_r3_homing_bar_", variation, "_top_right.stl"),

   // Convex R2 top and R3 bottom left
   str("../stl/cs_r2_r3_homing_bar_convex/cs_r2_r3_homing_bar_convex_", variation, "_top_left.stl"),
   str("../stl/cs_r2_r3_homing_bar_convex/cs_r2_r3_homing_bar_convex_", variation, "_bottom_left.stl"),

   // Convex R3 top
   str("../stl/cs_r3_r3_homing_bar_convex/cs_r3_r3_homing_bar_convex_", variation, "_top_left.stl"),
];

use <stl_combiner.scad>
combine_stl(keycaps);
