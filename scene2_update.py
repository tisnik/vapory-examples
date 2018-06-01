#!/usr/bin/env python3
# vim: set fileencoding=utf-8

from vapory import *

y = [0, 1, 0]
z = [0, 0, 1]

camera = Camera('location', [1.65, 5.5,-5.0],
                'up',       [ 0.0, 1.0, 0.0],
                'right',    [ 4/3, 0.0, 0.0],
                'look_at',  [ 0.0, 0.5,-1.0])

# tři světelné zdroje
light1 = LightSource([-30, 11, 20],
                     'color', 'White')

light2 = LightSource([31, 12, -20],
                     'color', 'White')

light3 = LightSource([32, 11, -20],
                     'color', 'LightGray')

# jediný uzavřený objekt ve scéně - zelená skleněná koule
sphere = Sphere([0, 0, 0],
                1.75,
                Interior(
                    'caustics', 1.0,
                    'ior', 1.5),
                Texture(
                    'T_Glass1',
                    Pigment('color', 'green', 0.9,
                            'filter', 0.85),
                    Finish('phong', 1,
                           'phong_size', 300,
                           'reflection', 0.15)))

# druhý objekt - nekonečná rovina
plane = Plane(y,
              -1.5,
              Texture(
                  'T_Stone1',
                  Pigment('octaves', 3,
                          'rotate', [i * 90 for i in z]),
                  Finish('reflection', 0.10)))

scene = Scene(camera,
              objects=[light1, light2, light3, sphere, plane],
              included=["colors.inc", "stones.inc", "glass.inc"],
              global_settings=["assumed_gamma 2.2"])

scene.render("scene2B_vapory.png", width=640, height=480)
