// ------------------------------------------------------------
// Jednoduchá scéna s jednou implicitní plochou vymodelovanou
// pomocí dvou prvků kostry - jednoho bodového prvku kostry a
// jednoho úsečkového prvku kostry se zápornou silou.
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B100 +FN +D +Iblobs2.pov +Oblobs2.png
// (pro náhled postačí zadat povray blobs2.pov)
// ------------------------------------------------------------

// globální nastavení parametrů scény
global_settings {
    assumed_gamma 2.2
    max_trace_level 5
}

// načtení všech potřebných externích souborů
#include "colors.inc"
#include "stones.inc"
#include "glass.inc"

// nastavení kamery (pozorovatele)
camera {
    location  <1.65, 5.5, -5.0>          // pozice kamery
    up        <0.0,  1.0,  0.0>          // vektor směřující vzhůru
    right     <4/3,  0.0,  0.0>          // vektor směřující doprava
    look_at   <0,    0.8, -1.0>          // bod, na který kamera směřuje
}

// tři světelné zdroje
light_source {
    <-30, 11,  20>                       // pozice světelného zdroje
    color White                          // barva světla
}

light_source {
    < 31, 12, -20>                       // pozice světelného zdroje
    color White                          // barva světla
}

light_source {
    < 32, 11, -20>                       // pozice světelného zdroje
    color LightGray                      // barva světla
}

// první objekt - implicitní plocha
blob {
    threshold 0.5
    sphere {                             // bodový (kulový) prvek kostry
        <0, 0, 0>,                       // souřadnice středu
        2.0,                             // poloměr
        2.0                              // síla
    }
    cylinder {                           // prvek kostry se zápornou silou
        <0, -2, 0>,
        <0,  2, 0>,
        0.5,
        -2.0
    }

    interior {                           // vlastnosti "vnitřku" implicitní plochy
        caustics 1.0
        ior 1.5
    }
    texture {                            // textura - povrch implicitní plochy
        T_Glass1                         // definováno v externím souboru
        pigment {
            color blue 0.80 red 0.80 filter 0.85  // barva povrchu
        }
        finish {                         // optické vlastnosti materiálu
            phong 1                      // velikost a síla odlesků
            phong_size 300
            reflection 0.15              // odrazivost
        }
    }
    rotate <15,105,0>
    scale 2.1
}

// druhý objekt - nekonečná rovina
plane {
    y,                                   // orientace roviny
    -2.5                                 // vzdálenost od počátku
    texture {                            // textura - vlastnosti povrchu
        T_Stone2                         // definováno v externím souboru
        pigment {                        // vlastní vzorek textury
            octaves 3                    // modifikace procedurálního vzorku
            rotate 90*z
        }
        finish {                         // optické vlastnosti materiálu
            reflection 0.10
        }
    }
}



// ------------------------------------------------------------
// finito
// ------------------------------------------------------------ 
