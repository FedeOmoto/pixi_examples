import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class Ball {
  Sprite sprite;
  num x;
  num y;

  Ball(this.sprite) {
    x = sprite.position.x;
    y = sprite.position.y;
  }
}

class BallsDemo {
  int w = 1024;
  int h = 768;
  double sx;
  double sy;
  int slideX;
  int slideY;
  Random random = new Random();
  List<Ball> balls = new List<Ball>();
  Stage stage;
  Renderer renderer;

  BallsDemo() {
    var ballTexture = new Texture.fromImage('assets/bubble_32x32.png');
    //renderer = new CanvasRenderer(width: w, height: h);
    //renderer = new WebGLRenderer(width: w, height: h);
    renderer = new Renderer.autoDetect(width: w, height: h);
    stage = new Stage();
    sx = 1.0 + (random.nextDouble() / 20);
    sy = 1.0 + (random.nextDouble() / 20);
    slideX = (w ~/ 2);
    slideY = (h ~/ 2);

    document.body.append(renderer.view);

    for (int i = 0; i < 2500; i++) {
      var tempBall = new Sprite(ballTexture);

      tempBall.position.x = random.nextInt(w) - slideX;
      tempBall.position.y = random.nextInt(h) - slideY;
      tempBall.anchor.x = 0.5;
      tempBall.anchor.y = 0.5;

      balls.add(new Ball(tempBall));

      stage.addChild(tempBall);
    }

    querySelector('#rnd').onClick.listen(newWave);
    querySelector('#sx').innerHtml = 'SX: $sx<br />SY: $sy';

    resize();

    window.animationFrame.then(update);
  }

  void newWave(MouseEvent event) {
    sx = 1.0 + (random.nextDouble() / 20);
    sy = 1.0 + (random.nextDouble() / 20);
    querySelector('#sx').innerHtml = 'SX: $sx<br />SY: $sy';
  }

  void resize([Event event]) {
    w = window.innerWidth - 16;
    h = window.innerHeight - 16;

    slideX = (w ~/ 2);
    slideY = (h ~/ 2);

    renderer.resize(w, h);
  }

  void update(num value) {
    balls.forEach((star) {
      star.sprite.position.x = star.x + slideX;
      star.sprite.position.y = star.y + slideY;
      star.x = (star.x * sx);
      star.y = (star.y * sy);

      if (star.x > w) {
        star.x = star.x - w;
      } else if (star.x < -w) {
        star.x = star.x + w;
      }

      if (star.y > h) {
        star.y = star.y - h;
      } else if (star.y < -h) {
        star.y = star.y + h;
      }
    });

    renderer.render(stage);

    window.animationFrame.then(update);
  }
}

void main() {
  var demo = new BallsDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
