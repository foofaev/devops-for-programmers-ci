// @ts-check

const path = require('path');

const migrations = {
  directory: path.join(__dirname, 'server', 'migrations'),
};

const isProduction = process.env.NODE_ENV === 'production';

const settings = {
  client: 'pg',
  version: '13',
  asyncStackTraces: true,
  connection: isProduction
    ? {
      connectionString: process.env.DATABASE_URL,
      ssl: { rejectUnauthorized: false },
    }
    : {
      host: process.env.POSTGRES_HOST,
      user: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DB,
    },
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
