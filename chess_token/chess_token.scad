hauteur = 3.4;
diametre = 39;
fn = 100;
internal_diametre = diametre - (diametre / 3.5);
largeur_creux = 2;
profondeur_creux = 1;
logo = "logo_fixed.stl";

module logo () {
 translate([2.2, 0, 0]) resize([22, 22, profondeur_creux], auto=false)import(logo, convexity=3, center=true);
}

module creux() {
    difference() {
        cylinder(h=hauteur, d=internal_diametre, center=true, $fn=fn);
        cylinder(h=hauteur, d=internal_diametre - largeur_creux, center=true, $fn=fn);
    }
}

module jeton () {
    difference() {
        cylinder(h=hauteur, d=diametre, center=true, $fn=fn);
        translate([0, 0, hauteur - profondeur_creux]) creux();
        translate([0, 0, -hauteur + profondeur_creux]) creux();
    }
}

difference() {
    jeton();
    translate([0, 0, (hauteur / 2) - profondeur_creux + 0.1]) logo();
    translate([0, 0, -(hauteur / 2) - 0.1]) logo();
}