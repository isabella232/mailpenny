var path = require('path'),
    rootPath = path.normalize(__dirname + '/..'),
    env = process.env.NODE_ENV || 'development';

var config = {
  development: {
    root: rootPath,
    app: {
      name: 'mailman'
    },
    port: process.env.PORT || 3000,
    db: process.env.DATABASE_URL || 'postgres://localhost/mailman-development'
  },

  test: {
    root: rootPath,
    app: {
      name: 'mailman'
    },
    port: process.env.PORT || 3000,
    db: process.env.DATABASE_URL || 'postgres://localhost/mailman-test'
  },

  production: {
    root: rootPath,
    app: {
      name: 'mailman'
    },
    port: process.env.PORT || 3000,
    db: process.env.DATABASE_URL || 'postgres://localhost/mailman-test'
  }
};

module.exports = config[env];
