// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

import { Application } from '@hotwired/stimulus'
import { Autocomplete } from 'stimulus-autocomplete'

import "chartkick"
import "Chart.bundle"

const application = Application.start()
application.register('autocomplete', Autocomplete)
