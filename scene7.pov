// ------------------------------------------------------------
// Jednoduchá scéna s jednou implicitní plochou vymodelovanou
// pomocí tří prvků kostry.
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B +FN +D +Iscene7.pov +Oscene7.png
// (pro náhled postačí zadat povray scene7.pov)
// ------------------------------------------------------------

#version 3.5;

#include "colors.inc"

global_settings {
    assumed_gamma 2.2
}

camera {
   location <0, 0, -2.5>                 // umístění kamery
   up       y                            // a nahoru
   right    4/3 * x                      // vektor směřující doprava
   look_at  <0, 0, 0>                    // bod, na který se kamera zaměřila
}

light_source {                           // první světelný zdroj
    <2, 10, -10>                         // pozice světelného zdroje
    color red 0.7 green 0.7 blue 0.7     // barva světelného zdroje
}

light_source {                           // druhý světelný zdroj
    <0, 0, -10000>                       // pozice světelného zdroje
    color red 0.7 green 0.7 blue 0.7     // barva světelného zdroje
    shadowless
}

plane {                                  // rovina tvořící pozadí scény
    <0, 0, 1>, 2                         // posun a orientace roviny
    // hollow on
    pigment {                            // procedurální textura
        agate
        agate_turb 0.3
    }
    finish {                             // optické vlastnosti materiálu povrchu
        ambient 0.1
        diffuse 0.4
    }
}

blob {
    threshold 0.6                        // hraniční hodnota
    component 1.0, 1.0, < 0.750,  0, 0>  // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, <-0.375,  0.64952, 0> // druhý prvek kostry
    component 1.0, 1.0, <-0.375, -0.64952, 0> // třetí prvek kostry

    texture {
        pigment {
            color red 0 green 0 blue 1   // barva materiálu
        }
        finish {                         // optické vlastnosti materiálu povrchu
            ambient  0.2
            diffuse  0.4
            specular 0.6
            phong    0.6
            phong_size 3
            reflection 0
        }
    }
}

// ------------------------------------------------------------
// finito
// ------------------------------------------------------------ 
