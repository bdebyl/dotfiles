# dotfiles
This is an up to date collection of my configuration files for all-the-things
linux.

## Usage
To best apply the configuration files, it is recommended to
use [stow](https://www.gnu.org/software/stow/manual/stow.html) to automatically
create the symlinks in the adequate directories for you.

Simply use `stow` on a directory, as follows:
```
$ stow xinit/
```
Then observe the symlinks created in your `$HOME` directory for the files in
`./xinit/`.
