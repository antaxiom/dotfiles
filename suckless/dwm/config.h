/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 3;        /* border pixel of windows */
static const unsigned int snap     = 32;       /* snap pixel */
static const unsigned int gappih   = 16;       /* horiz inner gap between windows */
static const unsigned int gappiv   = 16;       /* vert inner gap between windows */
static const unsigned int gappoh   = 16;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov   = 16;       /* vert outer gap between windows and screen edge */
static       int smartgaps         = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar           = 1;        /* 0 means no bar */
static const int topbar            = 1;        /* 0 means bottom bar */
static const int user_bh           = 46;        /* 0 means that dwm will calculate bar height, >        = 1 means dwm will user_bh as bar height */
static const int horizpadbar       = 16;        /* horizontal padding for statusbar */
static const int vertpadbar        = 6;        /* vertical padding for statusbar */
static const int usealtbar         = 0;        /* 1 means use non-dwm status bar */
static const char *altbarclass     = "Polybar"; /* Alternate bar class name */
static const char *alttrayname     = "tray";    /* Polybar tray instance name */
static const char *fonts[]         = { "JetBrains Mono Medium:antialias=true:autohint=true", "Noto Sans CJK JP:antialias = true:autohint = true","JetBrainsMonoNF:size = 15:antialias = true:autohint = true" };
static const char dmenufont[]      = "JetBrainsMonoNF";
static const char col_gray1[]      = "#111111";
static const char col_gray2[]      = "#222222";
static const char col_gray3[]      = "#454545";
static const char col_gray4[]      = "#eeeeee";
static const char col_cyan[]       = "#61afef";
static const char col_magenta[]    = "#5BC6D1";
static const char *colors[][3]     = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray3 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_magenta  },
	[SchemeStatus]  = { col_cyan, col_gray1,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { col_gray1, col_cyan,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  = { col_cyan, col_gray1,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  = { col_gray4, col_gray1,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  = { col_gray3, col_gray1,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	//{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[〇]",      monocle },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} }, \

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-p", "run","-m", dmenumon, NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          SHCMD("j4-dmenu-desktop --no-generic  --dmenu=\'dmenu -p start\'")},
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_e,      spawn,          SHCMD("SUDO_ASKPASS=~/suckless/dwm/dpass sudo -A $(dmenu_path | dmenu -p run)")},
	{ MODKEY,                       XK_a,      spawn,          SHCMD("thunar")},
	{ MODKEY,                       XK_s,      spawn,          SHCMD("brave")},
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Up,   incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_Down,     incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_i,      setlayout,      {.v = &layouts[9]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[11]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_r,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} }, { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} }, { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} }, { ClkTagBar,            0,              Button1,        view,           {0} }, { ClkTagBar,            0,              Button3,        toggleview,     {0} }, { ClkTagBar,            MODKEY,         Button1,        tag,            {0} }, { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} }, };
