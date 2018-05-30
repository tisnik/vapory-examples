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
