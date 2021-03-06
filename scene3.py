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

"""Složitější těleso vzniklé s využitím CSG - Constructive Solid Geometry."""

from vapory import *

# často používané vektory
x = [1, 0, 0]
y = [0, 1, 0]
z = [0, 0, 1]

# vytvoření kamery ve scéně
camera = Camera('location', [1.65, 5.5, -5.0],
                'up',       [0.0, 1.0, 0.0],
                'right',    [4/3, 0.0, 0.0],
                'look_at',  [0.0, 0.5, -1.0])

# tři světelné zdroje
light1 = LightSource([-30, 11, 20],
                     'color', 'White')

light2 = LightSource([31, 12, -20],
                     'color', 'White')

light3 = LightSource([32, 11, -20],
                     'color', 'LightGray')

VEL = 1.45  # velikost krychle

csg_object = Difference(
    Box([-VEL, -VEL, -VEL],
        [VEL, VEL, VEL],
        Texture(
            'T_Wood23',
            Finish('phong', 1,
                   'phong_size', 300,
                   'reflection', 0.15))),
    Sphere([0, 0, 0],
           1.8,
           Texture(
               'T_Wood24',
               Finish('phong', 1,
                      'phong_size', 300,
                      'reflection', 0.15)))
)

# druhý objekt - nekonečná rovina
plane = Plane(y,
              -1.5,
              Texture(
                  'T_Stone1',
                  Pigment('octaves', 3,
                          'rotate', [i * 90 for i in z]),
                  Finish('reflection', 0.10)))

# složení scény z jednotlivých objektů
scene = Scene(camera,
              objects=[light1, light2, light3, csg_object, plane],
              included=["colors.inc", "stones.inc", "woods.inc"],
              global_settings=["assumed_gamma 2.2"])

# vykreslení scény do souboru
scene.render("scene3_vapory.png", width=640, height=480)
