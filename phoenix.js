const MODIFIERS = [ 'ctrl', 'alt', 'cmd' ];

/* Pseudo full screen */
const maximize = (screen, window) => {
  const newFrame = {
    x: window.frame().x,
    y: window.frame().y,
    width: screen.width - 85,
    height: screen.height - 55
  };

  window.setFrame(newFrame);
};

const center = (screen, window) => {
  window.setTopLeft({
    x: screen.x + (screen.width / 2) - (window.frame().width / 2),
    y: screen.y + (screen.height / 2) - (window.frame().height / 2)
  });
};

/* Center */
Key.on('c', MODIFIERS, () => {
  const screen = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !screen) return;

  maximize(screen, window);
  center(screen, window);
});

/* Reload */
Key.on( 'r', MODIFIERS, () => Phoenix.reload() );

/* Move window */
Key.on('left', MODIFIERS, () => {
  const window = Window.focused();
  const currentScreen = window.screen();
  const screens = Screen.all();

  const nextScreen = screens
    .find(screen => screen.identifier() !== currentScreen.identifier())
    .flippedVisibleFrame();

  maximize(nextScreen, window);
  center(nextScreen, window);
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
