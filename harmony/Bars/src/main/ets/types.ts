export type SystemBarStyle = "light-content" | "dark-content" | string;

export type StatusBarProps = {
  statusBarStyle: SystemBarStyle;
};

export type NavigationBarProps = {
  navigationBarStyle: SystemBarStyle;
};

export type SystemBarsProps = StatusBarProps;
