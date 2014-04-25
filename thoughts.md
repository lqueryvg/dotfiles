tmux/vim thoughts
````
Here's how I want copy/paste to work when using tmux and vim:

- Terminal mouse copy/paste must work as usual.
  I.e. all mouse operations should be sent by default to the terminal,
  whether this be putty, xterm or cygwin mintty.
  You would therefore be able to select any text including part of the
  vim or tmux status lines or tab names.

- Via a modifier key, use mouse to select/resize tmux/vim vim panes/windows.

#### Mintty

Mintty has "Application Mouse Mode" option allowing choice
of mouse click target (application or window) and an override key.
So, with default click target of Window and Ctrl as override key, normal
behaviour is resumed for mintty mouse unless Ctrl is also pressed.
Job done.

#### Putty
Putty mouse clicks won't be passed at all to tmux or vim if
"Disable xterm-style mouse reporting" is checked (under Terminal -> Features).
There's an option under Window -> Selection which says
"Shift overrides application's use of mouse".
This is the opposite of what I want.

TODO - No idea how to solve this yet, but I don't use tmux with putty (yet).
Maybe patch putty ?

#### xterm
xterm passes all mouse clicks to tmux and vim.
I could possibly remap things.
There are XTerm*VT100.translations options to override mappings.
Examples:
xterm -xrm 'XTerm*VT100.translations: #override <Btn1Up>: select-end(PRIMARY, CLIPBOARD, CUT_BUFFER0)'
xterm -xrm 'XTerm*VT100.translations: #override Ctrl<Btn1Up>: insert()'
xterm -xrm 'XTerm*VT100.translations: #override Ctrl<Btn1Up>: insert()\n\
  Ctrl<Btn1Down>: ignore()'

But it seems the events are being passed through to the application
before these mappings are processed.
E.g. the following:
  xterm -xrm 'XTerm*VT100.translations: #override <Btn1Up>: ignore()'
breaks default xterm mouse selection, yet tmux mouse still works.

### Stepping Back
Stepping back, perhaps it would be better to try to
customise this this once and for all terminal emulators via tmux/vim.

But it seems that perhaps even this is not possible.
Tmux would need to pass mouse event back to xterm unless modifier
key is pressed. Firstly I don't know if it's possible to remap
mouse actions in Tmux (looks like it's only possible to turn certain mouse
interactions on or off). Secondly I don't see how it's going to be possible
to send these events back to xterm (both for Tmux to send and for xterm to
receive).

### Stepping In again...
How about an alternative to xterm ?
rxvt - can't see an option for this
mintty for Linux - I think this is Cygwin only
terminator - d-bus problems
roxterm - d-bus problems

### Stepping Back Again
Perhaps I'm being unreasonable and I should learn to use Shift to perform native
selections ? The problem is that I need my muscle memory to be portable
to places where xterm and putty are the norm - with no tmux.
For now I've given up on this. I will try to work with both approaches.
I.e.
1. when tmux is available, single tmux session with minimal mouse usage
2. when tmux is not available, multiple tty sessions and traditional copy/paste
```
