import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class Button extends Sprite {
  bool isDown = false;
  bool isOver = false;

  Button(Texture texture) : super(texture);
}

class InteractivityDemo {
  Stage stage;
  Renderer renderer;
  Texture textureButton;
  Texture textureButtonDown;
  Texture textureButtonOver;

  InteractivityDemo() {
    // Create an new instance of a pixi stage.
    stage = new Stage(Color.black);

    // Create a renderer instance.
    //renderer = new CanvasRenderer(width: 620, height: 400);
    //renderer = new WebGLRenderer(width: 620, height: 400);
    renderer = new Renderer.autoDetect(width: 620, height: 400);

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    window.animationFrame.then(animate);

    // Create a background.
    var background = new Sprite.fromImage('button_test_BG.jpg');

    // Add background to stage.
    stage.addChild(background);

    // Create some textures from an image path.
    textureButton = new Texture.fromImage('button.png');
    textureButtonDown = new Texture.fromImage('buttonDown.png');
    textureButtonOver = new Texture.fromImage('buttonOver.png');

    var buttons = new List<Button>();

    var buttonPositions = [175, 75, 600 - 145, 75, 600 / 2 - 20, 400 / 2 + 10,
        175, 400 - 75, 600 - 115, 400 - 95];

    for (int i = 0; i < 5; i++) {
      var button = new Button(textureButton);
      button.buttonMode = true;

      button.anchor.x = 0.5;
      button.anchor.y = 0.5;

      button.position.x = buttonPositions[i * 2];
      button.position.y = buttonPositions[i * 2 + 1];

      // Make the button interactive.
      button.interactive = true;

      // Set the mousedown and touchstart listerners.
      button.onMouseDown.listen(turnOn);
      button.onTouchStart.listen(turnOn);

      // Set the mouseup and touchend listeners.
      button.onMouseUp.listen(switchLabel);
      button.onTouchEnd.listen(switchLabel);
      button.onMouseUpOutside.listen(switchLabel);
      button.onTouchEndOutside.listen(switchLabel);

      // Set the mouseover listener.
      button.onMouseOver.listen(labelOn);

      // Set the mouseout listener.
      button.onMouseOut.listen(labelOff);

      // Set the click listener.
      button.onClick.listen((event) => print('CLICK!'));

      // Set the tap listener.
      button.onTap.listen((event) => print('TAP!'));

      // Add it to the stage.
      stage.addChild(button);

      // Add button to list.
      buttons.add(button);
    }

    // Set some silly values.
    buttons[0].scale.x = 1.2;
    buttons[1].scale.y = 1.2;
    buttons[2].rotation = PI / 10;
    buttons[3].scale.x = 0.8;
    buttons[3].scale.y = 0.8;
    buttons[4].scale.x = 0.8;
    buttons[4].scale.y = 1.2;
    buttons[4].rotation = PI;

    // Add a logo!
    var pixiLogo = new Sprite.fromImage('pixi.png');
    stage.addChild(pixiLogo);

    pixiLogo.buttonMode = true;

    pixiLogo.position.x = 620 - 56;
    pixiLogo.position.y = 400 - 32;

    pixiLogo.interactive = true;

    pixiLogo.onClick.listen((event) {
      window.open('https://github.com/FedeOmoto/pixi/', '_blank');
    });

    pixiLogo.onTap.listen((event) {
      window.open('https://github.com/FedeOmoto/pixi/', '_blank');
    });
  }

  void turnOn(InteractionData event) {
    var button = event.target as Button;

    button.isDown = true;
    button.setTexture(textureButtonDown);
    button.alpha = 1.0;
  }

  void switchLabel(InteractionData event) {
    var button = event.target as Button;

    button.isDown = false;

    if (button.isOver) {
      button.setTexture(textureButtonOver);
    } else {
      button.setTexture(textureButton);
    }
  }

  void labelOn(InteractionData event) {
    var button = event.target as Button;

    button.isOver = true;
    if (button.isDown) return;
    button.setTexture(textureButtonOver);
  }

  void labelOff(InteractionData event) {
    var button = event.target as Button;

    button.isOver = false;
    if (button.isDown) return;
    button.setTexture(textureButton);
  }

  void animate(num value) {
    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new InteractivityDemo();
}
