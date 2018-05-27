'use strict';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import * as actions from './actions';

function mapDispatchToProps(dispatch) {
    return {
        actions: bindActionCreators(actions, dispatch)
    };
}

var routes = [];

export default routes;
