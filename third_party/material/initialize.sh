#!/usr/bin/env bash
# (re-)initialize and build the material components web bundle

VERSION="14.0.0"

cat <<EOF >package.json
{
  "private": true,
  "scripts": {
    "build": "webpack --mode=production"
  }
}
EOF

npm install "@material/auto-init@${VERSION}"
npm install "@material/button@${VERSION}"
npm install "@material/fab@${VERSION}"
npm install "@material/checkbox@${VERSION}"
npm install "@material/data-table@${VERSION}"
npm install "@material/dialog@${VERSION}"
npm install "@material/icon-button@${VERSION}"
npm install "@material/form-field@${VERSION}"
npm install "@material/list@${VERSION}"
npm install "@material/menu@${VERSION}"
npm install "@material/menu-surface@${VERSION}"
npm install "@material/select@${VERSION}"
npm install "@material/textfield@${VERSION}"

npm install --save-dev css-loader
npm install --save-dev extract-loader
npm install --save-dev file-loader
npm install --save-dev mini-css-extract-plugin
npm install --save-dev path
npm install --save-dev sass
npm install --save-dev sass-loader
npm install --save-dev webpack
npm install --save-dev webpack-cli

npm run build
