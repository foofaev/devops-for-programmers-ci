// @ts-check

const path = require('path');

const migrations = {
  directory: path.join(__dirname, 'server', 'migrations'),
};

const connectionStringExists = !!process.env.DATABASE_URL;
const connectionOptions = connectionStringExists
  ? { connectionString: process.env.DATABASE_URL }
  : {
    connection: {
      host: process.env.POSTGRES_HOST,
      user: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DB,
    },
  };

const settings = {
  client: 'pg',
  version: '12',
  asyncStackTraces: true,
  ...connectionOptions,
  pool: {
    afterCreate(connection, done) {
      connection.query("SET timezone='UTC';", (error) => done(error, connection));
    },
  },
  useNullAsDefault: true,
  migrations,
};

module.exports = {
  development: settings,
  production: settings,
  test: settings,
};
