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

from vapory import *


class Blob(POVRayElement):
    """Blob()"""


# často používané vektory
x = [1, 0, 0]
y = [0, 1, 0]
z = [0, 0, 1]

# vytvoření kamery ve scéně
camera = Camera('location', [0.0, 0.0, -2.5],
                'up',       [0.0, 1.0, 0.0],
                'right',    [4/3, 0.0, 0.0],
                'look_at',  [ 0.0, 0.0, 0.0])

# dva světelné zdroje
light1 = LightSource([2, 10, -10],
                     'color', [0.7, 0.7, 0.7])

light2 = LightSource([0, 0, -10000],
                     'color', [0.7, 0.7, 0.7],
                     'shadowless')

# první objekt - blob/metaball
blob = Blob('threshold', 0.6,
            'component', 1.0, 1.0, [0.750, 0.000, 0.000],
            'component', 1.0, 1.0, [-.375, 0.64952, 0.000],
            'component', 1.0, 1.0, [-.375, -0.64952, 0.000],
            Texture(
                Pigment('color', [0, 0, 1]),
                Finish('ambient', 0.2,
                       'diffuse', 0.4,
                       'specular', 0.6,
                       'phong', 0.6,
                       'phong_size', 3,
                       'reflection', 0)))

# druhý objekt - nekonečná rovina
plane = Plane(z,
              2,
              'hollow', 'on',
              Texture(
                  Pigment('agate',
                          'agate_turb', 0.3),
                  Finish('ambient', 0.1,
                         'diffuse', 0.4)))

# složení scény z jednotlivých objektů
scene = Scene(camera, objects=[light1, light2, plane, blob],
              included=['colors.inc'],
              global_settings=['assumed_gamma 2.2'])

# vykreslení scény do souboru
scene.render('scene7_vapory.png', width=400, height=300)
