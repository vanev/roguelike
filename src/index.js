'use strict';
require('./index.html')
require('./styles/index.scss')

const { Elm } = require('./Main.elm')
const node = document.getElementById('app');

const app = Elm.Main.init({ node })
