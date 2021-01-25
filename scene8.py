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
x = (1, 0, 0)
y = (0, 1, 0)
z = (0, 0, 1)

# vytvoření kamery ve scéně
camera = Camera('orthographic',
                'location', (0, 0, -1),
                'right', '5*4/3*x',
                'up', 'y*5',
                'look_at', (0, 0, 0))

# dva světelné zdroje
light1 = LightSource((2, 10, -10),
                     'color', (0.7, 0.7, 0.7))

light2 = LightSource((0, 0, -10000),
                     'color', (0.7, 0.7, 0.7),
                     'shadowless')


# objekt - nekonečná rovina
plane = Plane(z,
              2,
              'hollow', 'on',
              Texture(
                  Pigment('agate',
                          'agate_turb', 0.9),
                  Finish('ambient', 0.1,
                         'diffuse', 0.4)))


def new_blob(threshold, dx, dy):
    return Blob('threshold', threshold,
                'component', 1.0, 1.0, (0, -0.6, 0),
                'component', 1.0, 1.0, (0,  0.6, 0),
                Texture(
                      Pigment('color', (0.6, 0.8, 1.0)),
                      Finish('ambient', 0.2,
                             'diffuse', 0.4,
                             'phong', 0.5,
                             'phong_size', 5)),
                'translate', (dx, dy, 0))


objects=[light1, light2, plane]
objects.append(new_blob(0.40, -2.00, -1.2))
objects.append(new_blob(0.50, -0.65, -1.2))
objects.append(new_blob(0.60,  0.65, -1.2))
objects.append(new_blob(0.70,  2.00, -1.2))
objects.append(new_blob(0.75, -2.00, 1.2))
objects.append(new_blob(0.80, -0.65, 1.2))
objects.append(new_blob(0.82,  0.65, 1.2))
objects.append(new_blob(0.90,  2.00, 1.2))

# složení scény z jednotlivých objektů
scene = Scene(camera, objects=objects,
              included=('colors.inc',),
              global_settings=('assumed_gamma 2.2',))

# vykreslení scény do souboru
scene.render('scene8_vapory.png', width=400, height=300, auto_camera_angle=False)
