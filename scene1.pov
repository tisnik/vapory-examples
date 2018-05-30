// ------------------------------------------------------------
// Jednoduchá scéna s jedním uzavřeným objektem, jedním nekonečným
// objektem, jedním světlem a jednou kamerou (pozorovatelem)
//
// rendering lze spustit příkazem:
//     povray +W800 +H600 +B +FN +D +Iscena2.pov +Oscena2.png
// (pro náhled postačí zadat povray scena1.pov)
// ------------------------------------------------------------

#version 3.5;

// globální nastavení parametrů scény
global_settings {
    assumed_gamma 2.2
    max_trace_level 5
}

// nastavení kamery (pozorovatele)
camera {
    location  <0.0, 2.0,-3.0>        // pozice kamery
    up        <0.0, 1.0, 0.0>        // vektor směřující vzhůru
    right     <4/3, 0.0, 0.0>        // vektor směřující doprava
    look_at   <0.0, 1.0, 2.0>        // bod, na který kamera směřuje
}

// světelný zdroj
light_source {
    <2, 4, -3>                       // pozice světelného zdroje
    color <1,1,1>                    // barva světla
}

// jediný uzavřený objekt ve scéně - zelená koule
sphere {
    <0, 1, 2>,                           // souřadnice středu koule
    2.00                                 // poloměr koule
    texture {                            // textura - povrch koule
        pigment {
            color <1.0, 1.0, 0.0>        // barva povrchu
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
        pigment {
            color <1,1,1>                // barva povrchu
        }
        finish {                         // optické vlastnosti materiálu
            reflection 0.10
        }
    }
}



// ------------------------------------------------------------
// finito
// ------------------------------------------------------------ 
