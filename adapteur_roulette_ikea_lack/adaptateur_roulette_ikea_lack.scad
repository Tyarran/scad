epaisseur = 5;
largeur_pied = 50;
hauteur_socle = 50;
x_roulette = 71.5;
hauteur_roulette = 26;

module trou_vis_socle()
{
    translate([ 0, 0, -10 ]) rotate([ 0, 90, 0 ]) cylinder(h = x_roulette, d = 3, center = true, $fn = 100);
    translate([ (largeur_pied / 2) + (epaisseur / 2), 0, -10 ]) rotate([ 0, 90, 0 ])
        cylinder(h = 4, d = 8, center = true, $fn = 100);
}

module socle()
{
    function compute_hauteur_trou_socle(d) = (hauteur_socle / 2) - (d / 2);

    difference()
    {
        cube([ largeur_pied + epaisseur, largeur_pied + epaisseur, hauteur_socle ], center = true);
        translate([ 0, 0, epaisseur ]) cube([ largeur_pied, largeur_pied, hauteur_socle + 0.1 ], center = true);
        translate([ 0, 0, compute_hauteur_trou_socle(d = 8) ]) trou_vis_socle();
        translate([ 0, 0, compute_hauteur_trou_socle(d = 8) ]) mirror([ 1, 0, 0 ]) trou_vis_socle();
    }
}

module trou_roulette(l, l2, x, y)
{
    translate([ (l / 2) - x, (l2 / 2) - y, -5.1 ]) cylinder(h = hauteur_roulette - 10, d = 4, center = true, $fn = 50);
}

module support_roulette(x, y, z)
{
    difference()
    {
        cube([ x, y, z ], center = true);
        union()
        {
            trou_roulette(x_roulette, largeur_pied, 11, 11 - 1.5);
            mirror([ 1, 0, 0 ]) trou_roulette(x_roulette, largeur_pied, 11, 11 - 1.5);
            mirror([ 0, 1, 0 ]) trou_roulette(x_roulette, largeur_pied, 11, 11 - 1.5);
            mirror([ 1, 0, 0 ]) mirror([ 0, 1, 0 ]) trou_roulette(x_roulette, largeur_pied, 11, 11 - 1.5);
        }
    }
}

union()
{
    translate([ 0, 0, hauteur_roulette - 3 ]) socle();
    support_roulette(x_roulette, largeur_pied + epaisseur, hauteur_roulette);
}
