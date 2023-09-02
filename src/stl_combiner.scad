// Adds multiple stl into one file and then connects them with
// cylinder sprues for cost-effective printing at JLCPCB


module gen_sprues(count, spacing=18, sprue_len=2.5, sprue_radius=0.8) {

        for (i = [0 : count - 1]) {
            translate([
                spacing/2 + i * spacing - sprue_len / 2,
                0,
                - 0.9 * sprue_radius
            ])
                rotate ([0, 90, 0])
                    cylinder(
                        h = sprue_len,
                        r = sprue_radius,
                        $fn=15
                    );
        }
}

module combine_stl(stl_array, spacing=18, sprue_len=2.5, sprue_radius=0.8) {
    union() {
        for (i = [0 : len(stl_array) - 1]) {
            stl = stl_array[i];
            translate([i * spacing, 0, 0]) import(stl);
        }

        gen_sprues(len(stl_array) - 1);
    };
}
