const path = require("path");
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

module.exports = [{
  entry: {
    script: ['./app.js'],
    styles: ['./app.scss'],
  },
  devtool: 'source-map',
  output: {
    path: path.resolve(__dirname, 'bundle'),
    filename: '[name].min.js',
  },
  plugins: [
    new MiniCssExtractPlugin({
        filename: '[name].css',
    }),
  ],
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      }
    ]
  },
}];
