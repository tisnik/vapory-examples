// ------------------------------------------------------------
// Aplikace CSG operace rozdílu koule a krychle
//
// Založeno na souboru původně vytvořeném Danem Farmerem (leden 2002)
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B +FN +D +Iscena2.pov +Oscena2.png
// (pro náhled postačí zadat povray scena3.pov)
// ------------------------------------------------------------

#version 3.5;

// globální nastavení parametrů scény
global_settings {
    assumed_gamma 2.2
    max_trace_level 5
}

// načtení všech potřebných externích souborů
#include "colors.inc"
#include "stones.inc"
#include "glass.inc"
#include "woods.inc"

// nastavení kamery (pozorovatele)
camera {
    location  <1.65, 5.5, -5.0>          // pozice kamery
    up        <0.0,  1.0,  0.0>          // vektor směřující vzhůru
    right     <4/3,  0.0,  0.0>          // vektor směřující doprava
    look_at   <0,    0.5, -1.0>          // bod, na který kamera směřuje
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

#declare VEL=1.45;                       // velikost krychle

difference {
    box {
        <-VEL, -VEL, -VEL>               // jeden z vrcholů krychle na tělesové úhlopříčce
        < VEL,  VEL,  VEL>               // druhý z vrcholů krychle na tělesové úhlopříčce
        texture {                        // textura - povrch krychle
            T_Wood23                     // definováno v externím souboru
            finish {                     // optické vlastnosti materiálu
                phong 1                  // velikost a síla odlesků
                phong_size 300
                reflection 0.15          // odrazivost
            }
        }
    }
    sphere {
        <0, 0, 0>,                       // souřadnice středu koule
        1.8                              // poloměr koule
        texture {                        // textura - povrch koule
            T_Wood24                     // definováno v externím souboru
            finish {                     // optické vlastnosti materiálu
                phong 1                  // velikost a síla odlesků
                phong_size 300
                reflection 0.15          // odrazivost
            }
        }
    }
    rotate <0,45,0>                      // rotace výsledného "dvojtělesa"
}

// druhý objekt - nekonečná rovina
plane {
    y,                                   // orientace roviny
    -1.5                                 // vzdálenost od počátku
    texture {                            // textura - vlastnosti povrchu
        T_Stone1                         // definováno v externím souboru
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
