// The cutter expects keycaps to be centered at origin,
// but the cs keycaps stls are not.
// So here we adjust for that
cs_translate = [0, 18, 0];

// keycap_array_format = [
//    stl_path,
//    translate_adjustment,
//    rotation_adjustment,
//    mirror_adjustment,
// ]
cs_r2_top = [
   "../keycaps/chicago_steno/cs_r2_1.stl",

   // By default the r2 key is rotated for the bottom row
   // here we rotate it for the top row
   cs_translate, [0, 0, 180], [0, 0, 0]
];
cs_r2x_top = [
   "../keycaps/chicago_steno/cs_r2x_1.stl",

   // By default the r2x key is rotated for the bottom row
   // here we rotate it for the top row
   cs_translate, [0, 0, 180], [0, 0, 0]
];
cs_r2_lateral_top_r = [
   "../keycaps/chicago_steno/cs_r2_lateral_l.stl",

   // By default the r2_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   cs_translate, [0, 0, 180], [0, 0, 0]
];
cs_r2_lateral_top_l = [
   "../keycaps/chicago_steno/cs_r2_lateral_l.stl",

   // By default the r2_lateral key is rotated for the bottom row
   // here we rotate it for the top row.
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 180], [1, 0, 0]
];
cs_r3 = [
   "../keycaps/chicago_steno/cs_r3_1.stl",
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3_bar = [
   "../keycaps/chicago_steno/cs_r3_1_bar.stl",
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3_dot = [
   "../keycaps/chicago_steno/cs_r3_1_dot.stl",
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3x = [
   "../keycaps/chicago_steno/cs_r3x_1.stl",
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3_lateral_l = [
   "../keycaps/chicago_steno/cs_r3_lateral_l.stl",

   // By default the r3_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 180], [1, 0, 0]
];
cs_r3_lateral_r  = [
   "../keycaps/chicago_steno/cs_r3_lateral_l.stl",

   // By default the r3_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 180], [0, 0, 0]
];
cs_r3_lateral_r_dot = [
   "../keycaps/chicago_steno/cs_r3_lateral_r_dot.stl",

   // This is already correctly rotated and we don't need to do anything
    cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3_lateral_r_bar = [
   "../keycaps/chicago_steno/cs_r3_lateral_r_bar.stl",

   // This is already correctly rotated and we don't need to do anything
    cs_translate, [0, 0, 0], [0, 0, 0]
];
