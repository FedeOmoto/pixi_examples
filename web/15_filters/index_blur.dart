import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class BlurDemo {
  Stage stage;
  Renderer renderer;
  BlurFilter blurFilter1, blurFilter2;
  double count = 0.0;

  BlurDemo() {
    // Create an new instance of a pixi stage.
    stage = new Stage(Color.white);

    var bg = new Sprite.fromImage('depth_blur_BG.jpg');
    stage.addChild(bg);

    var littleDudes = new Sprite.fromImage('depth_blur_dudes.jpg');
    littleDudes.position.y = 100;
    stage.addChild(littleDudes);

    var littleRobot = new Sprite.fromImage('depth_blur_moby.jpg');
    littleRobot.position.x = 120;
    stage.addChild(littleRobot);

    blurFilter1 = new BlurFilter();
    blurFilter2 = new BlurFilter();

    littleDudes.filters = [blurFilter1];
    littleRobot.filters = [blurFilter2];

    // Create a renderer instance.
    renderer = new WebGLRenderer(width: 630, height: 410);
    renderer.view.style.position = 'absolute';
    renderer.view.style.width = '${window.innerWidth}px';
    renderer.view.style.height = '${window.innerHeight}px';
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    // Add a pixi Logo!
    var logo = new Sprite.fromImage('pixi.png');
    stage.addChild(logo);

    logo.anchor.x = logo.anchor.y = 1.0;
    logo.position.x = 630;
    logo.scale.x = logo.scale.y = 0.5;
    logo.position.y = 400;
    logo.interactive = true;
    logo.buttonMode = true;

    logo.onClick.listen((event) {
      window.open('https://github.com/FedeOmoto/pixi/', '_blank');
    });

    logo.onTap.listen((event) {
      window.open('https://github.com/FedeOmoto/pixi/', '_blank');
    });

    window.animationFrame.then(animate);
  }

  void animate(num value) {
    count += 0.01;

    double blurAmount = cos(count);
    double blurAmount2 = sin(count);

    blurFilter1.blur = 20 * blurAmount;
    blurFilter2.blur = 20 * blurAmount2;

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new BlurDemo();
}
