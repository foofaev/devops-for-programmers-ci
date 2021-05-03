import path from 'path';
import MiniCssExtractPlugin from 'mini-css-extract-plugin';

const mode = process.env.NODE_ENV || 'development';
const port = process.env.WEBPACK_DEV_PORT_INTERNAL || 5000;
const host = process.env.WEBPACK_DEV_HOST_INTERNAL || 'localhost';

module.exports = {
  mode,
  devtool: 'source-map',
  output: {
    path: path.join(__dirname, 'dist', 'public'),
  },
  devServer: {
    host,
    publicPath: '/assets/',
    port,
    compress: true,
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader',
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader'],
      },
    ],
  },
  plugins: [new MiniCssExtractPlugin()],
};
