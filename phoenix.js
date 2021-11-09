Phoenix.set({
  'daemon': true,
  'openAtLogin': true,
});

const MODIFIERS = [ 'ctrl', 'alt', 'cmd' ];
const PADDING = 35;

/* Sizing */
const halfWidth = (parentFrame) => {
  return {
    width: (parentFrame.width - (PADDING * 3)) / 2,
    height: parentFrame.height - (PADDING * 2),
  };
};

const halfHeight = (parentFrame) => {
  return {
    width: parentFrame.width - (PADDING * 2),
    height: (parentFrame.height - (PADDING * 3)) / 2,
  };
};

const quarterSize = (parentFrame) => {
  return {
    width: halfWidth(parentFrame).width,
    height: halfHeight(parentFrame).height,
  };
};

const fullSize = (parentFrame) => {
  return {
    width: halfHeight(parentFrame).width,
    height: halfWidth(parentFrame).height,
  };
};

/* Position */
const topLeft = () => {
  return {
    x: PADDING,
    y: PADDING,
  };
};

const topRight = (parentFrame, window) => {
  return {
    x: halfWidth(parentFrame).width + (PADDING * 2),
    y: PADDING,
  };
};

const bottomLeft = (parentFrame, window) => {
  return {
    x: PADDING,
    y: halfHeight(parentFrame).height + (PADDING * 2),
  };
};

const bottomRight = (parentFrame, window) => {
  return {
    x: topRight(parentFrame, window).x,
    y: bottomLeft(parentFrame, window).y,
  };
};

const center = (parentFrame, window) => {
  return {
    x: parentFrame.x + (parentFrame.width / 2) - (window.frame().width / 2),
    y: parentFrame.y + (parentFrame.height / 2) - (window.frame().height / 2),
  };
};

/* Center */
Key.on('c', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setTopLeft(center(parentFrame, window));
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

  window.setTopLeft(center(nextScreen, window));
});

/* "Full" screen */
Key.on('f', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setFrame({...fullSize(parentFrame), ...topLeft()});
});

/* Move window */
Key.on('h', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setFrame({...quarterSize(parentFrame), ...topLeft()});
});

Key.on('j', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setFrame({...quarterSize(parentFrame), ...bottomLeft(parentFrame, window)});
});

Key.on('k', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setFrame({...quarterSize(parentFrame), ...bottomRight(parentFrame, window)});
});

Key.on('l', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setFrame({...quarterSize(parentFrame), ...topRight(parentFrame, window)});
});

/* Size window */
Key.on('\\', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setSize(halfWidth(parentFrame));
});

Key.on('-', MODIFIERS, () => {
  const parentFrame = Screen.main().flippedVisibleFrame();
  const window = Window.focused();

  if (!window || !parentFrame) return;

  window.setSize(halfHeight(parentFrame));
});

/* Apps */
Key.on('t', MODIFIERS, () => {
  App.launch('Kitty').focus();
});

Key.on('b', MODIFIERS, () => {
  App.launch('Firefox Developer Edition').focus();
});

Key.on('s', MODIFIERS, () => {
  App.launch('Slack').focus();
})
