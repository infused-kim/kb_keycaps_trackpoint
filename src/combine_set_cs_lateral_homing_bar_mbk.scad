// This set contains all chicago steno lateral keycaps for both 3-row and
// 4-row keyboards. It has the top row keys in both R2 and R3 variations.
//
// On top of that it includes all MBK keycaps.

key_stagger = "corne";
key_profile = "choc";

variation = str(key_profile, "_", key_stagger);

keycaps = [
   // R2R3 Levee
   str("../stl/cs_r2_r3_lateral_homing_bar/cs_r2_r3_lateral_homing_bar_", variation, "_top_left.stl"),
   str("../stl/cs_r2_r3_lateral_homing_bar/cs_r2_r3_lateral_homing_bar_", variation, "_top_right.stl"),
   str("../stl/cs_r2_r3_lateral_homing_bar/cs_r2_r3_lateral_homing_bar_", variation, "_bottom_left.stl"),
   str("../stl/cs_r2_r3_lateral_homing_bar/cs_r2_r3_lateral_homing_bar_", variation, "_bottom_right.stl"),

   // R3 Top Levee
   str("../stl/cs_r3_r3_lateral_homing_bar/cs_r3_r3_lateral_homing_bar_", variation, "_top_left.stl"),
   str("../stl/cs_r3_r3_lateral_homing_bar/cs_r3_r3_lateral_homing_bar_", variation, "_top_right.stl"),

   // MBK
   str("../stl/mbk/mbk_", variation, "_top_left.stl"),
   str("../stl/mbk/mbk_", variation, "_top_right.stl"),
   str("../stl/mbk/mbk_", variation, "_bottom_left.stl"),
   str("../stl/mbk/mbk_", variation, "_bottom_right.stl"),
];

use <stl_combiner.scad>
combine_stl(keycaps);
