"use strict";

import { Elm } from "./src/Main.elm";

const node = document.getElementById("app");
const app = Elm.Main.init({ node });
