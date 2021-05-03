#! /usr/bin/env node

import getApp from '..';

const port = process.env.SERVER_PORT || 3000;
const address = process.env.SERVER_ADDRESS || '127.0.0.1';

getApp().listen(port, address, (error, builtAddress) => {
  if (error) {
    console.error(error); // eslint-disable-line no-console
    process.exit(1);
  }
  console.log(`Server is running on address: ${builtAddress}`); // eslint-disable-line no-console
});
