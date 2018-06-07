// ------------------------------------------------------------
// Jednoduchá scéna s několika implicitními plochami (blobs),
// které se liší pouze hodnotou threshold.
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B100 +FN +D +Iscene8.pov +Oscene8.png
// (pro náhled postačí zadat povray scene8.pov)
// ------------------------------------------------------------

#version 3.5;

#include "colors.inc"

global_settings {
    assumed_gamma 2.2
}

camera {
   orthographic                          // vypnutí perspektivy
   location <0, 0, -1>                   // umístění kamery
   right    5*4/3 * x                    // vektor směřující doprava
   up       y*5                          // a nahoru
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
    hollow on
    pigment {                            // procedurální textura
        agate
        agate_turb 0.9
    }
    finish {                             // optické vlastnosti materiálu povrchu
        ambient 0.1
        diffuse 0.4
    }
}

#declare Tex =
texture {
    pigment {
        color red 0.6 green 0.8 blue 1
    }
    finish {
        ambient 0.2 diffuse 0.4 phong 0.5 phong_size 5
    }
}

blob {
    threshold 0.4                        // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate <-2.0, -1.2, 0>
}

blob {
    threshold 0.5                        // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate <-0.65, -1.2, 0>
}

blob {
    threshold 0.6                        // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate < 0.65, -1.2, 0>
}

blob {
    threshold 0.7                        // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate < 2.0, -1.2, 0>
}

blob {
    threshold 0.75                       // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate <-2.0, 1.2, 0>
}

blob {
    threshold 0.8                        // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate <-0.65, 1.2, 0>
}

blob {
    threshold 0.82                       // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate < 0.65, 1.2, 0>
}

blob {
    threshold 0.9                        // hraniční hodnota
    component 1.0, 1.0, < 0, -0.6, 0>    // prvek kostry: síla, poloměr, souřadnice v prostoru
    component 1.0, 1.0, < 0,  0.6, 0>    // druhý prvek kostry
    texture {Tex}
    translate < 2.0, 1.2, 0>
}

// ------------------------------------------------------------
// finito
// ------------------------------------------------------------
