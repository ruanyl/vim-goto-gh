vim-goto-gh
===========

go to the github repo of a package in package.json

![dotfile1](https://cloud.githubusercontent.com/assets/486382/10679050/b75cd3bc-791e-11e5-958b-8f379915d842.gif)

How to install
-----------------------
###Vundle
Put this in your .vimrc

```vim
Bundle 'ruanyl/vim-goto-gh'
```

Then restart vim and run `:BundleInstall`.
To update the plugin to the latest version, you can run `:BundleUpdate`.

How to use
----------

For convenience it is recommended that you assign a key for this, like so:

      nnoremap <Leader>o :Gotogh<CR>
