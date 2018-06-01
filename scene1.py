#!/usr/bin/env python3
# vim: set fileencoding=utf-8

#
#  (C) Copyright 2018  Pavel Tisnovsky
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

y = [0, 1, 0]


camera = Camera('location', [0.0, 2.0, -3.0],
                'up',       [0.0, 1.0, 0.0],
                'right',    [4/3, 0.0, 0.0],
                'look_at',  [0.0, 1.0, 2.0])

light = LightSource([2, 4, -3],
                    'color', [1, 1, 1])

sphere = Sphere([0, 1, 2],
                2.0,
                Texture(
                    Pigment('color', [1, 1, 0]),
                    Finish('phong', 1,
                           'phong_size', 300,
                           'reflection', 0.15)))

plane = Plane(y,
              -1.5,
              Texture(
                  Pigment('color', [1, 1, 1]),
                  Finish('reflection', 0.10)))

scene = Scene(camera,
              objects=[light, sphere, plane])

scene.render("scene1_vapory.png", width=640, height=480)
