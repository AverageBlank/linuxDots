Hello, This is my gitlab for all of my dotfiles.
if you are interested in using them you can go ahead and clone them using this command: "git clone https://github.com/StudGaming/dotfiles"

Here is a small explanation on how to set up the file that you cloned: 

Vim :-
In order for the vimrc to work properly you will need to run this command in the terminal :
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
And then go in to the vimrc using:

```vim ~/.vimrc```(asuming you put the vimrc in the home folder)

Once you're in run:

```:source %```

and after that:

```:PlugInstall```(this is case sensitive)
