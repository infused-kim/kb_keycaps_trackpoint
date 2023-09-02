key_stagger = "corne";
key_profile = "choc";

variation = str(key_profile, "_", key_stagger);

keycaps = [
   // R2R3 Levee
   str("../stl/cs_r2_r3_levee/cs_r2_r3_levee_", variation, "_top_left.stl"),
   str("../stl/cs_r2_r3_levee/cs_r2_r3_levee_", variation, "_top_right.stl"),
   str("../stl/cs_r2_r3_levee/cs_r2_r3_levee_", variation, "_bottom_left.stl"),
   str("../stl/cs_r2_r3_levee/cs_r2_r3_levee_", variation, "_bottom_right.stl"),

   // R3 Top Levee
   str("../stl/cs_r3_r3_levee/cs_r3_r3_levee_", variation, "_top_left.stl"),
   str("../stl/cs_r3_r3_levee/cs_r3_r3_levee_", variation, "_top_right.stl"),

   // MBK
   str("../stl/mbk/mbk_", variation, "_top_left.stl"),
   str("../stl/mbk/mbk_", variation, "_top_right.stl"),
   str("../stl/mbk/mbk_", variation, "_bottom_left.stl"),
   str("../stl/mbk/mbk_", variation, "_bottom_right.stl"),
];

use <stl_combiner.scad>
combine_stl(keycaps);
