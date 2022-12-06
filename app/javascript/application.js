// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "local-time.js"
import * as bootstrap from "bootstrap"
import LocalTime from "local-time"
LocalTime.start()