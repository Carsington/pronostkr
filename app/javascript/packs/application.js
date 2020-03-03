import Rails from 'rails-ujs';
import "bootstrap";

import { placeForecast } from './place_forecast';
// import { initSortable } from '../../../src/plugins/init_sortable';

Rails.start();

// initSortable();
placeForecast();
