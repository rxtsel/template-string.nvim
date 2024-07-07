# 😸 template-string.nvim

`template-string.nvim` is a simple Neovim plugin for handling template strings in JavaScript and TypeScript files. It provides functionality to wrap template literals with `{``}` when inside JSX/TSX components and revert them back to their original form when necessary.

## Features

- Automatically wraps template literals with backticks ``` `` ``` when a `${}` expression is added within single or double quotes in JavaScript or TypeScript files.
- Wraps template literals with `{``}` when inside JSX/TSX components.
- Reverts template literals to their original form when the `${}` expression is removed.
- Integration with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for accurate detection and manipulation of JSX/TSX nodes, enhancing its functionality and precision.

## Supported Languages

- JavaScript
- TypeScript
- JSX
- TSX

## Installation

Install using your favorite package manager for Neovim. For example, using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "rxtsel/template-string.nvim",
    event = "BufReadPost",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    }
}
```

## Usage

Once installed, the plugin automatically wraps template literals with backticks `` `...` `` when a `${}` expression is added within single or double quotes in JavaScript or TypeScript files. For example, changing `"Hello, ${name}"` to `` `Hello, ${name}` ``. In JSX/TSX, it wraps with `{``}`.

### JavaScript/TypeScript

```javascript
const name = "World";
const greeting = `Hello, ${name}!`;
console.log(greeting);
```

### JSX/TSX

```jsx
const props = {
  name: "World",
};

<Test greeting={`Hello, ${props.name}!`} />;
```

## License

This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
