import 'dart:html';
import 'dart:js';
import 'package:pixi_dart/pixi.dart' as pixi;

class TextDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Text spinningText;
  pixi.Text countingText;
  int count = 0;
  int score = 0;

  init() {
    var assetsToLoad = ['desyrel.fnt'];

    // Create a new loader.
    var loader = new pixi.AssetLoader(assetsToLoad);

    // Use callback.
    loader.onComplete.listen(onAssetsLoaded);

    // Begin load.
    loader.load();

    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(new pixi.Color(0x66FF99));

    // Add a shiney background.
    var background = new pixi.Sprite.fromImage('textDemoBG.jpg');
    stage.addChild(background);

    // Create a renderer instance.
    //renderer = new pixi.CanvasRenderer(width: 620, height: 400);
    //renderer = new pixi.WebGLRenderer(width: 620, height: 400);
    renderer = new pixi.Renderer.autoDetect(width: 620, height: 400);

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    window.animationFrame.then(animate);

    // Create some white text using the Snippet webfont.
    var textStyle = new pixi.TextStyle()..font = '35px Snippet';
    var textSample = new pixi.Text('Pixi Dart can has\nmultiline text!',
        textStyle);
    textSample.position.x = 20;
    textSample.position.y = 20;

    // Create a text object with a nice stroke.
    textStyle = new pixi.TextStyle()
        ..font = 'bold 60px Podkova'
        ..fill = new pixi.Color(0xcc00ff)
        ..align = 'center'
        ..stroke = pixi.Color.white
        ..strokeThickness = 6;
    spinningText = new pixi.Text("I'm fun!", textStyle);

    // Setting the anchor point to 0.5 will center align the text, great for
    // spinning!
    spinningText.anchor.x = spinningText.anchor.y = 0.5;
    spinningText.position.x = 620 / 2;
    spinningText.position.y = 400 / 2;

    // Create a text object that will be updated.
    textStyle = new pixi.TextStyle()
        ..font = 'bold italic 60px Arvo'
        ..fill = new pixi.Color(0x3e1707)
        ..align = 'center'
        ..stroke = new pixi.Color(0xa4410e)
        ..strokeThickness = 7;
    countingText = new pixi.Text('COUNT 4EVAR: 0', textStyle);
    countingText.position.x = 620 / 2;
    countingText.position.y = 320;
    countingText.anchor.x = 0.5;

    stage.addChild(textSample);
    stage.addChild(spinningText);
    stage.addChild(countingText);

    var count = 0;
    var score = 0;
  }

  void onAssetsLoaded(CustomEvent event) {
    var textStyle = new pixi.BitmapTextStyle()
        ..font = '35px Desyrel'
        ..align = 'right';
    var bitmapFontText = new pixi.BitmapText(
        'bitmap fonts are\n now supported!', textStyle);
    bitmapFontText.position.x = 620 - bitmapFontText.textWidth - 6;
    bitmapFontText.position.y = 20;

    stage.addChild(bitmapFontText);
  }

  void animate(num value) {
    window.animationFrame.then(animate);

    count++;

    if (count == 50) {
      count = 0;
      score++;

      // Update the text.
      countingText.text = 'COUNT 4EVAR: $score';
    }

    // Just for fun, lets rotate the text.
    spinningText.rotation += 0.03;

    // Render the stage.
    renderer.render(stage);
  }
}

void main() {
  var textDemo = new TextDemo();
  var jsMap = new JsObject.jsify({
    'google': {
      'families': ['Snippet', 'Arvo:700italic', 'Podkova:700']
    },
    'active': textDemo.init
  });

  context['WebFont'].callMethod('load', [jsMap]);
}
