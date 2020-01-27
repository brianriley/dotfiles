Key.on('c', [ 'ctrl', 'alt', 'cmd' ], function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    const newFrame = {
      x: window.frame().x,
      y: window.frame().y,
      width: screen.width - 85,
      height: screen.height - 55
    };

    window.setFrame(newFrame);
    window.setTopLeft({
      x: screen.x + (screen.width / 2) - (window.frame().width / 2),
      y: screen.y + (screen.height / 2) - (window.frame().height / 2)
    });
  }
});
