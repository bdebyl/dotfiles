# dotfiles
This is an up to date collection of my configuration files for all-the-things
linux.

# Usage
To best apply the configuration files, it is recommended to
install [stow](https://www.gnu.org/software/stow/manual/stow.html) to allow
usage of the handy `Makefile`

## Makefile
### `make stow`
Stows all dotfile packages (_directories_)

### `make restow`
Re-stows (deletes then stows) all the dotfile packages

### `make delete`
Deletes the symlinks created by stow (_"un-stows"_)

## Without Makefile
Simply use `stow` on a directory, as follows:
```
$ stow bash/
```
Then observe the symlinks created in your `$HOME` directory for the files in
`./xinit/`.

To stow all directories (_sub-shell to `/bin/bash` used to circumvent any
aliases_):
```
$ stow $(/bin/bash -c 'ls -d */')
```
