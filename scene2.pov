// ------------------------------------------------------------
// Jednoduchá scéna s jedním uzavřeným objektem, jedním nekonečným
// objektem, trojicí světel a jednou kamerou (pozorovatelem)
//
// Založeno na souboru původně vytvořeném Danem Farmerem (leden 2002)
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B +FN +D +Iscena2.pov +Oscena2.png
// (pro náhled postačí zadat povray scena2.pov)
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

// jediný uzavřený objekt ve scéně - zelená skleněná koule
sphere {
    <0, 0, 0>,                           // souřadnice středu koule
    1.75                                 // poloměr koule
    interior {                           // vlastnosti "vnitřku" koule
        caustics 1.0                     // světelná "prasátka"
        ior 1.5                          // index lomu
    }
    texture {                            // textura - povrch koule
        T_Glass1                         // definováno v externím souboru
        pigment {
            color green 0.90 filter 0.85 // barva povrchu
        }
        finish {                         // optické vlastnosti materiálu
            phong 1                      // velikost a síla odlesků
            phong_size 300
            reflection 0.15              // odrazivost
        }
    }
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
