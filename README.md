# vim-smart-object

Usually if you type `ci{` while not in a `{}` block nothing will happen. This plugin makes Vim look for a block on the same line before giving up. This saves you two keystrokes and less than a second. No big deal, but it feels a lot smoother to do some common programming tasks.


## Examples

```JavaScript
function foo(bar, soo) {
    return;
}
```

Take this very useful snippet. With the cursor on the beginning of the first line you can do several neat things. `ci(` will empty the arguments so you can write others. `ci{` deletes the function body and lets you write a new one. `da{` deletes the entire function body including `{}`.


## Options

Add the following options to your `.vimrc` to customize the behaviour.

### `g:smart_object_commands`
Specify the commands to use with this plugin. Default is `c,d,y`.
```shell
let g:smart_object_commands = 'c,d'
```

### `g:smart_object_blocks`
Set the block types to use. Default is `{},(),[]`.
```shell
let g:smart_object_blocks = '(),[]'
```


## Note

This plugin only intervenes when not currently in a block. So if you try to change a function body inside a container `{}` which is normal in some languages with classes, `ci{` will empty the entire class, not just the function body. This is how Vim usually behaves. To change the function body you will have to type `f{ci{` like before.
