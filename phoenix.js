const MODIFIERS = [ 'ctrl', 'alt', 'cmd' ];

/* Pseudo full screen */
const maximize = (visibleFrame, window) => {
  const margin = 75;
  const newX      = visibleFrame.x + (margin / 2),
        newY      = visibleFrame.y + (margin / 2),
        newWidth  = visibleFrame.width - margin,
        newHeight = visibleFrame.height - margin;

  window.setTopLeft({x: newX, y: newY});
  window.setSize({width: newWidth, height: newHeight});
};

const center = (visibleFrame, window) => {
  window.setTopLeft({
    x: visibleFrame.x + (visibleFrame.width / 2) - (window.frame().width / 2),
    y: visibleFrame.y + (visibleFrame.height / 2) - (window.frame().height / 2)
  });
};

/* Center */
Key.on('c', MODIFIERS, () => {
  const visibleFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !visibleFrame) return;

  center(visibleFrame, window);
});

/* Center and maximize */
Key.on('z', MODIFIERS, () => {
  const visibleFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !visibleFrame) return;

  maximize(visibleFrame, window);
});

/* Reload */
Key.on( 'r', MODIFIERS, () => Phoenix.reload() );

/* Move window to different screen */
Key.on('left', MODIFIERS, () => {
  const window = Window.focused();
  const currentScreen = window.screen();
  const screens = Screen.all();

  const nextScreen = screens
    .find(screen => screen.identifier() !== currentScreen.identifier())
    .flippedVisibleFrame();

  center(nextScreen, window);
});

/* Move windoww to corners */
Key.on('h', MODIFIERS, () => {
  const visibleFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !visibleFrame) return;

  window.setTopLeft({
    x: 0,
    y: window.frame().y
  });
});

Key.on('j', MODIFIERS, () => {
  const visibleFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !visibleFrame) return;

  window.setTopLeft({
    x: window.frame().x,
    y: visibleFrame.y + (visibleFrame.height - window.frame().height)
  });
});

Key.on('k', MODIFIERS, () => {
  const visibleFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !visibleFrame) return;

  window.setTopLeft({
    x: window.frame().x,
    y: 0
  });
});

Key.on('l', MODIFIERS, () => {
  const visibleFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !visibleFrame) return;

  window.setTopLeft({
    x: visibleFrame.x + (visibleFrame.width - window.frame().width),
    y: window.frame().y
  });
});

/* Apps */
Key.on('t', MODIFIERS, () => {
  App.launch('Kitty').focus();
});

Key.on('f', MODIFIERS, () => {
  App.launch('Firefox Developer Edition').focus();
});

Key.on('s', MODIFIERS, () => {
  App.launch('Slack').focus();
})
