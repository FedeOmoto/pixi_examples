import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'package:pixi_dart/pixi.dart';

class MorphDemo {
  int w = 1024;
  int h = 768;

  int n = 2000;
  int d = 1;
  int current = 1;
  int objs = 17;
  double vx = 0.0;
  double vy = 0.0;
  double vz = 0.0;
  List<double> points1;
  List<double> points2;
  List<double> points3;
  List<double> tpoint1;
  List<double> tpoint2;
  List<double> tpoint3;
  List<Sprite> pixels;
  Random random = new Random();
  Stage stage;
  Renderer renderer;

  MorphDemo() {
    var pixelTexture = new Texture.fromImage('assets/pixel.png');
    //renderer = new CanvasRenderer(width: w, height: h);
    //renderer = new WebGLRenderer(width: w, height: h);
    renderer = new Renderer.autoDetect(width: w, height: h);
    stage = new Stage();

    points1 = new List<double>(n);
    points2 = new List<double>(n);
    points3 = new List<double>(n);
    tpoint1 = new List<double>(n);
    tpoint2 = new List<double>(n);
    tpoint3 = new List<double>(n);
    pixels = new List<Sprite>(n);

    document.body.append(renderer.view);

    makeObject(0);

    for (int i = 0; i < n; i++) {
      tpoint1[i] = points1[i];
      tpoint2[i] = points2[i];
      tpoint3[i] = points3[i];

      var tempPixel = new Sprite(pixelTexture);
      tempPixel.anchor.x = 0.5;
      tempPixel.anchor.y = 0.5;
      tempPixel.alpha = 0.5;
      pixels[i] = tempPixel;

      stage.addChild(tempPixel);
    }

    resize();

    new Timer(const Duration(seconds: 5), nextObject);

    window.animationFrame.then(update);
  }

  void nextObject() {
    current++;
    if (current > objs) current = 0;
    makeObject(current);
    new Timer(const Duration(seconds: 8), nextObject);
  }

  void makeObject(int type) {
    int xd;

    switch (type) {
      case 0:
        for (var i = 0; i < n; i++) {
          points1[i] = -50.0 + (random.nextDouble() * 100).round();
          points2[i] = 0.0;
          points3[i] = 0.0;
        }

        break;

      case 1:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(type * 360 / n) * 10);
          points2[i] = (cos(xd) * 10) * (sin(type * 360 / n) * 10);
          points3[i] = sin(xd) * 100;
        }

        break;

      case 2:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(type * 360 / n) * 10);
          points2[i] = (cos(xd) * 10) * (sin(type * 360 / n) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 3:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(xd) * 10);
          points2[i] = (cos(xd) * 10) * (sin(xd) * 10);
          points3[i] = sin(xd) * 100;
        }

        break;

      case 4:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(xd) * 10);
          points2[i] = (cos(xd) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 5:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(xd) * 10);
          points2[i] = (cos(i * 360 / n) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 6:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(i * 360 / n) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (cos(i * 360 / n) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 7:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(i * 360 / n) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (cos(i * 360 / n) * 10) * (sin(i * 360 / n) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 8:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (cos(i * 360 / n) * 10) * (sin(i * 360 / n) * 10);
          points3[i] = sin(xd) * 100;
        }

        break;

      case 9:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (cos(i * 360 / n) * 10) * (sin(xd) * 10);
          points3[i] = sin(xd) * 100;
        }

        break;

      case 10:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(i * 360 / n) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (cos(xd) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 11:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (sin(xd) * 10) * (sin(i * 360 / n) * 10);
          points3[i] = sin(xd) * 100;
        }

        break;

      case 12:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(xd) * 10);
          points2[i] = (sin(xd) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 13:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (sin(i * 360 / n) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 14:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (sin(xd) * 10) * (cos(xd) * 10);
          points2[i] = (sin(xd) * 10) * (sin(i * 360 / n) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 15:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(i * 360 / n) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (sin(i * 360 / n) * 10) * (sin(xd) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;

      case 16:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(i * 360 / n) * 10);
          points2[i] = (sin(i * 360 / n) * 10) * (sin(xd) * 10);
          points3[i] = sin(xd) * 100;
        }

        break;

      case 17:
        for (var i = 0; i < n; i++) {
          xd = -90 + (random.nextDouble() * 180).round();
          points1[i] = (cos(xd) * 10) * (cos(xd) * 10);
          points2[i] = (cos(i * 360 / n) * 10) * (sin(i * 360 / n) * 10);
          points3[i] = sin(i * 360 / n) * 100;
        }

        break;
    }
  }

  void resize([Event event]) {
    w = window.innerWidth - 16;
    h = window.innerHeight - 16;

    renderer.resize(w, h);
  }

  void update(num value) {
    double x3d, y3d, z3d, tx, ty, tz, ox;

    if (d < 250) d++;

    vx += 0.0075;
    vy += 0.0075;
    vz += 0.0075;

    for (var i = 0; i < n; i++) {
      if (points1[i] > tpoint1[i]) tpoint1[i] = tpoint1[i] + 1;
      if (points1[i] < tpoint1[i]) tpoint1[i] = tpoint1[i] - 1;
      if (points2[i] > tpoint2[i]) tpoint2[i] = tpoint2[i] + 1;
      if (points2[i] < tpoint2[i]) tpoint2[i] = tpoint2[i] - 1;
      if (points3[i] > tpoint3[i]) tpoint3[i] = tpoint3[i] + 1;
      if (points3[i] < tpoint3[i]) tpoint3[i] = tpoint3[i] - 1;

      x3d = tpoint1[i];
      y3d = tpoint2[i];
      z3d = tpoint3[i];

      ty = (y3d * cos(vx)) - (z3d * sin(vx));
      tz = (y3d * sin(vx)) + (z3d * cos(vx));
      tx = (x3d * cos(vy)) - (tz * sin(vy));
      tz = (x3d * sin(vy)) + (tz * cos(vy));
      ox = tx;
      tx = (tx * cos(vz)) - (ty * sin(vz));
      ty = (ox * sin(vz)) + (ty * cos(vz));

      pixels[i].position.x = ((512 * tx) / (d - tz) + w / 2).round();
      pixels[i].position.y = ((h / 2) - (512 * ty) / (d - tz)).round();
    }

    renderer.render(stage);

    window.animationFrame.then(update);
  }
}

void main() {
  var demo = new MorphDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
