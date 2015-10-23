var path = require('path'),
    rootPath = path.normalize(__dirname + '/..'),
    env = process.env.NODE_ENV || 'development';

var config = {
  development: {
    root: rootPath,
    app: {
      name: 'mailman'
    },
    port: 3000,
    db: 'postgres://localhost/mailman-development'
  },

  test: {
    root: rootPath,
    app: {
      name: 'mailman'
    },
    port: 3000,
    db: 'postgres://localhost/mailman-test'
  },

  production: {
    root: rootPath,
    app: {
      name: 'mailman'
    },
    port: 3000,
    db: 'postgres://localhost/mailman-production'
  }
};

module.exports = config[env];
