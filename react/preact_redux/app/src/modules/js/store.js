import { applyMiddleware, combineReducers, createStore } from 'redux';
import { hashHistory } from 'react-router';
import { routerMiddleware, routerReducer, syncHistoryWithStore } from 'react-router-redux';

import thunk from 'redux-thunk';

import * as reducers from './reducers';

export const store = createStore(combineReducers({
    ...reducers,
    routing: routerReducer
}), applyMiddleware(thunk, routerMiddleware(hashHistory)));

export const history = syncHistoryWithStore(hashHistory, store);
