import 'dart:html';
import 'dart:math';
import 'dart:js';
import 'package:pixi_dart/pixi.dart' as pixi;

class Fish extends pixi.Sprite {
  double direction;
  double turnSpeed;
  int speed;

  Fish(pixi.Texture texture) : super(texture);

  factory Fish.fromImage(String imageId, [bool crossorigin, pixi.ScaleModes<int>
      scaleMode = pixi.ScaleModes.DEFAULT]) {
    var texture = new pixi.Texture.fromImage(imageId, crossorigin, scaleMode);
    return new Fish(texture);
  }
}

class FiltersDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  JsArray filtersSwitchs;
  pixi.DisplacementFilter displacementFilter;
  List<pixi.Filter> filterCollection;
  pixi.DisplayObjectContainer pondContainer;
  pixi.Rectangle<int> bounds;
  List<Fish> fishs = new List<Fish>();
  pixi.TilingSprite overlay;
  double count = 0.0;

  FiltersDemo() {
    // Create a renderer instance.
    renderer = new pixi.WebGLRenderer(width: 630, height: 410);
    renderer.view.style.position = 'absolute';
    renderer.view.style.width = '${window.innerWidth}px';
    renderer.view.style.height = '${window.innerHeight}px';
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    filtersSwitchs = new JsObject.jsify([true, false, false, false, false,
        false, false, false, false, false, false]);

    var jsObject;
    var controller;
    var gui = new JsObject(context['dat']['GUI']);

    ////

    var displacementTexture = new pixi.Texture.fromImage('displacement_map.jpg'
        );
    displacementFilter = new pixi.DisplacementFilter(displacementTexture);

    var displacementFolder = gui.callMethod('addFolder', ['Displacement']);
    displacementFolder.callMethod('open', []);

    controller = displacementFolder.callMethod('add', [filtersSwitchs, '0']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'x': displacementFilter.scaleX
    });
    controller = displacementFolder.callMethod('add', [jsObject, 'x', 1, 200]);
    controller.callMethod('name', ['scaleX']);
    controller.callMethod('onChange', [(value) {
        displacementFilter.scaleX = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'y': displacementFilter.scaleY
    });
    controller = displacementFolder.callMethod('add', [jsObject, 'y', 1, 200]);
    controller.callMethod('name', ['scaleY']);
    controller.callMethod('onChange', [(value) {
        displacementFilter.scaleY = value.toDouble();
      }]);

    ////

    var blurFilter = new pixi.BlurFilter();

    var blurFolder = gui.callMethod('addFolder', ['Blur']);

    controller = blurFolder.callMethod('add', [filtersSwitchs, '1']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'blurX': blurFilter.blurX
    });
    controller = blurFolder.callMethod('add', [jsObject, 'blurX', 0, 32]);
    controller.callMethod('name', ['blurX']);
    controller.callMethod('onChange', [(value) {
        blurFilter.blurX = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'blurY': blurFilter.blurY
    });
    controller = blurFolder.callMethod('add', [jsObject, 'blurY', 0, 32]);
    controller.callMethod('name', ['blurY']);
    controller.callMethod('onChange', [(value) {
        blurFilter.blurY = value.toDouble();
      }]);

    ////

    var pixelateFilter = new pixi.PixelateFilter();

    var pixelateFolder = gui.callMethod('addFolder', ['Pixelate']);

    controller = pixelateFolder.callMethod('add', [filtersSwitchs, '2']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'x': pixelateFilter.sizeX
    });
    controller = pixelateFolder.callMethod('add', [jsObject, 'x', 1, 32]);
    controller.callMethod('name', ['PixelSizeX']);
    controller.callMethod('onChange', [(value) {
        pixelateFilter.sizeX = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'y': pixelateFilter.sizeY
    });
    controller = pixelateFolder.callMethod('add', [jsObject, 'y', 1, 32]);
    controller.callMethod('name', ['PixelSizeY']);
    controller.callMethod('onChange', [(value) {
        pixelateFilter.sizeY = value.toDouble();
      }]);

    ////

    var invertFilter = new pixi.InvertFilter();

    var invertFolder = gui.callMethod('addFolder', ['Invert']);

    controller = invertFolder.callMethod('add', [filtersSwitchs, '3']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'invert': invertFilter.invert
    });
    controller = invertFolder.callMethod('add', [jsObject, 'invert', 0, 1]);
    controller.callMethod('name', ['Invert']);
    controller.callMethod('onChange', [(value) {
        invertFilter.invert = value.toDouble();
      }]);

    ////

    var grayFilter = new pixi.GrayFilter();

    var grayFolder = gui.callMethod('addFolder', ['Gray']);

    controller = grayFolder.callMethod('add', [filtersSwitchs, '4']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'gray': grayFilter.gray
    });
    controller = grayFolder.callMethod('add', [jsObject, 'gray', 0, 1]);
    controller.callMethod('name', ['Gray']);
    controller.callMethod('onChange', [(value) {
        grayFilter.gray = value.toDouble();
      }]);

    ////

    var sepiaFilter = new pixi.SepiaFilter();

    var sepiaFolder = gui.callMethod('addFolder', ['Sepia']);

    controller = sepiaFolder.callMethod('add', [filtersSwitchs, '5']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'sepia': sepiaFilter.sepia
    });
    controller = sepiaFolder.callMethod('add', [jsObject, 'sepia', 0, 1]);
    controller.callMethod('name', ['Sepia']);
    controller.callMethod('onChange', [(value) {
        sepiaFilter.sepia = value.toDouble();
      }]);

    ////

    var twistFilter = new pixi.TwistFilter();

    var twistFolder = gui.callMethod('addFolder', ['Twist']);

    controller = twistFolder.callMethod('add', [filtersSwitchs, '6']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'angle': twistFilter.angle
    });
    controller = twistFolder.callMethod('add', [jsObject, 'angle', 0, 10]);
    controller.callMethod('name', ['Angle']);
    controller.callMethod('onChange', [(value) {
        twistFilter.angle = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'radius': twistFilter.radius
    });
    controller = twistFolder.callMethod('add', [jsObject, 'radius', 0, 1]);
    controller.callMethod('name', ['Radius']);
    controller.callMethod('onChange', [(value) {
        twistFilter.radius = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'x': twistFilter.offsetX
    });
    controller = twistFolder.callMethod('add', [jsObject, 'x', 0, 1]);
    controller.callMethod('name', ['offset.x']);
    controller.callMethod('onChange', [(value) {
        twistFilter.offsetX = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'y': twistFilter.offsetY
    });
    controller = twistFolder.callMethod('add', [jsObject, 'y', 0, 1]);
    controller.callMethod('name', ['offset.y']);
    controller.callMethod('onChange', [(value) {
        twistFilter.offsetY = value.toDouble();
      }]);

    ////

    var dotScreenFilter = new pixi.DotScreenFilter();

    var dotScreenFolder = gui.callMethod('addFolder', ['DotScreen']);

    controller = dotScreenFolder.callMethod('add', [filtersSwitchs, '7']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'angle': dotScreenFilter.angle
    });
    controller = dotScreenFolder.callMethod('add', [jsObject, 'angle', 0, 10]);
    controller.callMethod('onChange', [(value) {
        dotScreenFilter.angle = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'scale': dotScreenFilter.scale
    });
    controller = dotScreenFolder.callMethod('add', [jsObject, 'scale', 0, 1]);
    controller.callMethod('onChange', [(value) {
        dotScreenFilter.scale = value.toDouble();
      }]);

    ////

    var colorStepFilter = new pixi.ColorStepFilter();

    var colorStepFolder = gui.callMethod('addFolder', ['ColorStep']);

    controller = colorStepFolder.callMethod('add', [filtersSwitchs, '8']);
    controller.callMethod('name', ['apply']);

    jsObject = new JsObject.jsify({
      'step': colorStepFilter.step
    });
    controller = colorStepFolder.callMethod('add', [jsObject, 'step', 1, 100]);
    controller.callMethod('onChange', [(value) {
        colorStepFilter.step = value.toDouble();
      }]);

    jsObject = new JsObject.jsify({
      'step': colorStepFilter.step
    });
    controller = colorStepFolder.callMethod('add', [jsObject, 'step', 1, 100]);
    controller.callMethod('onChange', [(value) {
        colorStepFilter.step = value.toDouble();
      }]);

    ////

    var crossHatchFilter = new pixi.CrossHatchFilter();

    var crossHatchFolder = gui.callMethod('addFolder', ['CrossHatch']);

    controller = crossHatchFolder.callMethod('add', [filtersSwitchs, '9']);
    controller.callMethod('name', ['apply']);

    ////

    var rgbSplitterFilter = new pixi.RgbSplitFilter();

    var rgbSplitFolder = gui.callMethod('addFolder', ['RGB Splitter']);

    controller = rgbSplitFolder.callMethod('add', [filtersSwitchs, '10']);
    controller.callMethod('name', ['apply']);

    filterCollection = [displacementFilter, blurFilter, pixelateFilter,
        invertFilter, grayFilter, sepiaFilter, twistFilter, dotScreenFilter,
        colorStepFilter, crossHatchFilter, rgbSplitterFilter];

    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.red);

    pondContainer = new pixi.DisplayObjectContainer();
    stage.addChild(pondContainer);

    var bg = new pixi.Sprite.fromImage('displacement_BG.jpg');
    pondContainer.addChild(bg);

    int padding = 100;
    bounds = new pixi.Rectangle<int>(-padding, -padding, 630 + padding * 2, 410
        + padding * 2);
    var random = new Random();

    for (int i = 0; i < 20; i++) {
      int fishId = i % 4;
      fishId += 1;

      var fish = new Fish.fromImage('displacement_fish$fishId.png');
      fish.anchor.x = fish.anchor.y = 0.5;
      pondContainer.addChild(fish);

      fish.direction = random.nextDouble() * PI * 2;
      fish.speed = 2 + random.nextInt(2);
      fish.turnSpeed = random.nextDouble() - 0.8;

      fish.position.x = random.nextInt(bounds.width);
      fish.position.y = random.nextInt(bounds.height);

      fish.scale.x = fish.scale.y = 0.8 + random.nextDouble() * 0.3;
      fishs.add(fish);
    }

    overlay = new pixi.TilingSprite(new pixi.Texture.fromImage('zeldaWaves.png'
        ), 630, 410);
    overlay.alpha = 0.1;
    pondContainer.addChild(overlay);

    displacementFilter.scale.x = 50.0;
    displacementFilter.scale.y = 50.0;

    // Add a pixi Logo!
    var logo = new pixi.Sprite.fromImage('pixi.png');
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
    count += 0.1;

    var filtersToApply = new List<pixi.Filter>();

    for (int i = 0; i < filterCollection.length; i++) {
      if (filtersSwitchs[i]) filtersToApply.add(filterCollection[i]);
    }

    pondContainer.filters = filtersToApply.isNotEmpty ? filtersToApply : null;

    fishs.forEach((fish) {
      fish.direction += fish.turnSpeed * 0.01;
      fish.position.x += sin(fish.direction) * fish.speed;
      fish.position.y += cos(fish.direction) * fish.speed;

      fish.rotation = -fish.direction - PI / 2;

      // Wrap.
      if (fish.position.x < bounds.left) fish.position.x += bounds.width;
      if (fish.position.x > bounds.left + bounds.width) fish.position.x -=
          bounds.width;

      if (fish.position.y < bounds.top) fish.position.y += bounds.height;
      if (fish.position.y > bounds.top + bounds.height) fish.position.y -=
          bounds.height;
    });

    displacementFilter.offset.x = count * 10;
    displacementFilter.offset.y = count * 10;

    overlay.tilePosition.x = count * -10;
    overlay.tilePosition.y = count * -10;

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new FiltersDemo();
}
