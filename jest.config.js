module.exports = {
  testEnvironment: "node",
  reporters: ["default"],
  testMatch: ['**/*.spec.js'],
  haste: {
    enableSymlinks: true,
  },
  moduleNameMapper: {
    'tfpackage/(.*)': '<rootDir>/$1',
  },
};
