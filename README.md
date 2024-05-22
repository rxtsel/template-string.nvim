# 😸 template-string.nvim

`template-string.nvim` is a simple Neovim plugin for handling template strings in JavaScript and TypeScript files. It provides functionality to wrap template literals with `{``}` when inside JSX/TSX components and revert them back to their original form when necessary.

## Features

- Wrap template literals with `{``}` when inside JSX/TSX components.
- Revert template literals to their original form when necessary.
- Configurable options to enable/disable wrapping with `{``}`.

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
    },
    config = function()
        require("template-string").setup()
    end,
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

## Configuration

The `setup` function accepts an optional configuration object with the following options:

- **jsx_brackets** `boolean | nil`: Enable/disable wrapping template literals with `{``}` inside JSX/TSX components. Defaults to `true` if not provided.

```lua
-- Default configuration
require('template-string').setup({
    jsx_brackets = true, -- Wrap template literals with {``} inside JSX/TSX components
})
```

## License

This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.