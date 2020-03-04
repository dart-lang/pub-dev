Material
========

To update the material-components resources, update the `package.json` and run:

```bash
npm install
npm run build
```

## Using custom theme

Material components's theme can be styles using the `:root` selector:

````css
:root {
  --mdc-theme-primary: #0175C2;
}
````

Further style names can be found in the
[theming guide](https://material.io/develop/web/docs/theming/).

## Major version upgrades

The components and their required HTML DOM structure in `material-components-web`
may change between major versions. When upgrading, we need to check and
potentially change the layout of the components.
