// ------------------------------------------------------------
// Jednoduchá scéna s uzavřeným objektem, plochou, dvojicí světel
// a jednou kamerou (pozorovatelem)
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B +FN +D +Iscene5.pov +Oscene5.png
// (pro náhled postačí zadat povray scene5.pov)
//
// Založeno na souboru původně vytvořeném Danem Farmerem (leden 2002)
// ------------------------------------------------------------

#version 3.5;

// globální nastavení parametrů scény
global_settings {
    assumed_gamma 2.2
}

// načtení všech potřebných externích souborů
#include "colors.inc"

// nastavení kamery (pozorovatele)
camera {
    location  <0, 20, -15>               // pozice kamery
    look_at   <0, -2,   0>               // bod, na který kamera směřuje
}

// první (silnější) světelný zdroj s bílou barvou
light_source {
    <-50, 100, -80>                      // pozice světelného zdroje
    color rgb 1                          // barva světla (všech tří složek)
}

// druhý (slabší) světelný zdroj
light_source {
    <250, 25, -100>                      // pozice světelného zdroje
    color red 0.85 green 0.53 blue 0.10  // barva světla
}

// objekt ve scéně: torus (anuloid)
torus {
    7.0, 4.0                             // geometrické informace
                                         // (poloměry celého toroidu a "trubky")

    // spodní (podkladová) textura se základním vzorkem
    texture {
        pigment {                        // definice vzorku textury
           bozo                          // typ vzorku
           color_map {                   // dvě barvy, které se na vzorku střídají
            [0.0 0.4  color red 0.36 green 0.20 blue 0.09  color red 0.36 green 0.20 blue 0.09 ]
            [0.4 1.01 color red 0.858824 green 0.576471 blue 0.439216 color red 0.858824 green 0.576471 blue 0.439216]
            }
            scale <4, 0.15, 0.15>        // změna měřítka (velikosti) namapovaného vzorku
            rotate 45*y
        }
    }

    // horní textura, která přidává jemnější vzorek
    texture {
        finish {                         // vlastnosti materiálu
            phong 1                      // intenzita a
            phong_size 100               // velikost odlesků
            brilliance 3                 // míra změny odlesků s úhlem dopadu světelných paprsků
            ambient 0.2                  // ambientní složka (pro simulaci všesměrového světla)
            diffuse 0.8                  // difúzní složka (pro simulaci směrového světla)
        }
        pigment {                        // definice vzorku textury
            wood                         // typ vzorku
            turbulence 0.025
            color_map {                  // čtyři barvy, které se ve vzorku střídají
                [0.00 0.15 color red 0.42 green 0.26 blue 0.15 color red 0.85 green 0.53 blue 0.10 ]
                [0.15 0.40 color red 0.85 green 0.53 blue 0.10 color rgbf 1 ]
                [0.40 0.80 color rgbf 1  color red 0.85 green 0.53 blue 0.10 ]
                [0.80 1.01 color red 0.85 green 0.53 blue 0.10 color red 0.42 green 0.26 blue 0.15 ]
            }
            scale <3.5, 1, 1>            // změna měřítka a natočení vzorku
            translate -50*y
            rotate 1.5*z
        }
    }
}

plane {                                  // rovina tvořící pozadí scény
    <0, 1, 0>, -6                        // posun a orientace roviny
    texture {                            // textura - vlastnosti povrchu
        pigment {                        // vlastní vzorek textury
            checker color Gray color White*0.9
        }
        finish {                         // optické vlastnosti materiálu
            reflection 0.10
        }
        scale 4
    }
}



// ------------------------------------------------------------
// finito
// ------------------------------------------------------------ 
