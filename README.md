# Dotfiles

This is only public so I can easily share it across machines. There is probably nothing of interest for you here ... or is there?

## Letting me own your machine

```
bash <(curl -fsSL https://raw.github.com/fortes/dotfiles/master/bootstrap.sh)
```

If for some reason, you don't have `curl` installed (why?):

```
bash <(wget -qO- https://raw.github.com/fortes/dotfiles/master/bootstrap.sh)
```

You may need to add `--no-check-certificate` for the `wget` call, but that's kinda dangerous.

## Setup

Once you've run setup, you'll still have to do the following manual steps:

1. Generate this machine's SSH keys:

```
ssh-keygen -t rsa -b 4096 -C "$(hostname)"
```

Then add the key into GitHub and wherever else (use `pbcopy < ~/.ssh/id_rsa` on Mac).

2. Add any additional ssh keys into `~/.ssh`

3. Authorize your public keys on the new machine:

```
ssh-import-id gh:fortes
```

4. If you're me (which you're not), set the remote url for this repo in order to push:

  ```
  cd $HOME/dotfiles && git remote set-url origin git@github.com:fortes/dotfiles.git
  ```

5. Add your favorite servers into `.ssh/config`

6. Setup `.gitconfig.local`:

  ````
  [user]
    name = Your Name
    email = xyz@abc.com
  ```

## Additional Settings

TODO: Automate these steps.

### Debian / Ubuntu

* Depending on the machine, you may need `pavucontrol` in order to unmute your audio output via GUI.
** Alternatively, find the name of the desired output via `pacmd list-sinks` then run `pacmd set-default-sink $SINK_NAME`
* [Setup font hinting](https://wiki.debian.org/Fonts#Subpixel-hinting_and_Font-smoothing)?

### Mac

* [Map Caps Lock to Control](http://www.emacswiki.org/emacs/MovingTheCtrlKey)
* Setup Mac settings

### EC2

Manually set shell to zsh by editing `/etc/passwd`.

### Chromebook

* Map Caps Lock to Control: Should come through with user account though.
* Set root password via `crosh`
* Copy chroots from backup files
* Create chroots

#### TODO

* Mac settings & preferences
* Better colorschemes
