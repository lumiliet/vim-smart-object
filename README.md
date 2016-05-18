# vim-smart-object

Usually if you type `ci{` while not in a `{}` block nothing will happen. This plugin makes Vim look for a block on the same line before giving up.


## Examples

```JavaScript
function foo(bar, soo) {
    return;
}
```

Take this very useful snippet. With the cursor on the beginning of the first line you can do two neat things. `ci(` will empty the arguments so you can write others. `ci{` deletes the function body and lets you write a new one.


## Support

Supported commands: `c`,`d` and `y`.
Supported block types: `{}`, `()`, `[]`.
