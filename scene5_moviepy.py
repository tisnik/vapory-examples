#!/usr/bin/env python3
# vim: set fileencoding=utf-8

#
#  (C) Copyright 2018, 2021  Pavel Tisnovsky
#
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  which accompanies this distribution, and is available at
#  http://www.eclipse.org/legal/epl-v10.html
#
#  Contributors:
#      Pavel Tisnovsky
#

"""Objekt se složitější texturou, vytvoření animované sekvence snímků."""

from vapory import *
from moviepy.editor import VideoClip


class Torus(POVRayElement):
    """Torus()"""


# často používané vektory
x = [1, 0, 0]
y = [0, 1, 0]
z = [0, 0, 1]

# vytvoření kamery ve scéně
camera = Camera('location', [0, 20, -15],
                'look_at',  [0, -2, 0])

# dva světelné zdroje

# první (silnější) světelný zdroj s bílou barvou
light1 = LightSource([-50, 100, -80],
                     'color', [1.0, 1.0, 1.0])

# druhý (slabší) světelný zdroj
light2 = LightSource([250, 25, -100],
                     'color', [0.85, 0.53, 0.10])


# objekt - nekonečná rovina
plane = Plane(y,
              -6,
              Texture(
                  Pigment('checker',
                          'color', 'Gray',
                          'color', 'White*0.9'),
                  Finish('reflection', 0.10),
                  'scale', 4))


# objekt ve scéně: torus (anuloid)
def create_torus(t):
    return Torus(7.0, 4.0,
                 # spodní (podkladová) textura se základním vzorkem
                 Texture(
                     Pigment('bozo',
                             ColorMap([0.0, 0.4, 'color', [0.36, 0.20, 0.09],
                                                 'color', [0.36, 0.20, 0.09]],
                                      [0.4, 1.01, 'color', [0.85, 0.57, 0.44],
                                                  'color', [0.85, 0.57, 0.44]]),
                             'scale', [4, 0.15, 0.15],
                             'rotate', [0, 45, 0])),
                 # horní textura, která přidává jemnější vzorek
                 Texture(
                     Pigment('wood',
                             'turbulence', 0.025,
                             # čtyři barvy, které se ve vzorku střídají
                             ColorMap([0.00, 0.15, 'color', [0.42, 0.26, 0.15],
                                                   'color', [0.85, 0.53, 0.10]],
                                      [0.15, 0.40, 'color', [0.85, 0.53, 0.10],
                                                   'color', [1.00, 1.00, 1.00, 1.00]],
                                      [0.40, 0.80, 'color', [1.00, 1.00, 1.00, 1.00],
                                                   'color', [0.85, 0.53, 0.10]],
                                      [0.80, 1.01, 'color', [0.85, 0.53, 0.10],
                                                   'color', [0.42, 0.26, 0.15]]),
                             'scale', [3.5, 1, 1],
                             'translate', [0, -50, 0],
                             'rotate', [0, 0, 10.0 * t]
                             ),
                     Finish('phong', 1,
                            'phong_size', 100,
                            'brilliance', 3,
                            'ambient', 0.2,
                            'diffuse', 0.8)))


def construct_scene(t):
    """Funkce volaná pro vytvoření každého snímku v animaci."""
    torus = create_torus(t)

    return Scene(camera, objects=[light1, light2, plane, torus],
                 included=['colors.inc'],
                 global_settings=['assumed_gamma 2.2'])


# parametry animace
DURATION = 10
FPS = 20


def make_frame(t):
    """Callback funkce pro vytvoření jednoho snímku videa."""
    scene = construct_scene(t / DURATION)
    return scene.render(width=400, height=300, antialiasing=0.001)


# vytvoření objektu typu VideoClip
animation = VideoClip(make_frame, duration=DURATION)

# vykreslení všech snímků a jejich uložení do video souboru
animation.write_videofile('scene5.ogv', fps=FPS, progress_bar=True, bitrate="800000")
