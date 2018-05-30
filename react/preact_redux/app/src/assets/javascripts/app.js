'use strict';
import React, { Component } from 'react';
import { render } from 'react-dom';
import { bindActionCreators } from 'redux';
import { Provider, connect } from 'react-redux';
import { Router, Route, IndexRoute, Link } from 'react-router';
import { goBack, push } from 'react-router-redux';

import { history, store } from '../../modules/js/store';
import routes from '../../modules/js/routes';

const actions = {
  toIndex: function () { push('/') },
  back: goBack
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(actions, dispatch)
  };
}

import Container from './container';
const ContainerComponent = connect((state, ownProps) => ({ current: ownProps.location.pathname }), mapDispatchToProps)(Container);

import Home from '../../views/home/js/home';

class App extends Component {
  constructor(props, state) {
    super(props, state);
  }

  render(props, state) {
    return (
      <Provider store={store}>
        <Router history={history}>
          <Route path="/" component={ContainerComponent}>
            <IndexRoute component={Home} />
            {routes.map((route, index) => (
              <Route
                key={index}
                path={route.path}
                exact={route.exact}
                component={route.component}
              />
            ))}
          </Route>
        </Router>
      </Provider>
    )
  }
}

export default App;
