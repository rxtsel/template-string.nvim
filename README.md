# 😸 template-string.nvim

`template-string.nvim` is a simple Neovim plugin for handling template strings in JavaScript and TypeScript files. It provides functionality to wrap template literals with `{``}` when inside JSX/TSX components and revert them back to their original form when necessary.

## Features

- Wrap template literals with `{``}` when inside JSX/TSX components.
- Revert template literals to their original form when necessary.
- Integration with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): The plugin now utilizes nvim-treesitter to accurately detect and manipulate JSX/TSX nodes, enhancing its functionality and precision.

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

Once installed, the plugin automatically wraps template literals with **``** when editing JavaScript or TypeScript files. To use template literals, simply enclose your JavaScript or TypeScript expressions in `${}`. For example:

```javascript
// Javascript/TypeScript
const name = "World";
const greeting = `Hello, ${name}!`;
console.log(greeting);
```

On JSX/TSX components, the plugin will wrap template literals with `{``}`. For example:

```jsx
const props = {
  name: "World",
};

<Test greeting={`Hello, ${props.name}!`} />;
```

## License

This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
