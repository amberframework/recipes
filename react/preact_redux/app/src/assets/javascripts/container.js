'use strict';
import React, { Component } from 'react';
import { Link } from 'react-router';
import { ToastContainer, toast } from 'react-toastify';

import EventBus from '../../lib/js/eventBus';
import Auth from '../../lib/js/auth';
import routes from '../../modules/js/routes';

export default class Container extends Component {

  authenticateWithToken(token) {
    let vm = this;
    let $ = window.$;

    $.ajax(
      {
        url: "/authenticateWithToken?token=" + token,
        method: 'GET',
        dataType: 'json'
      })
      .done(function (data) {
        window.csrf_token = data.csrf;
        Auth.authenticateUser(data.token, data.user);
        vm.setState({ current_user: data.user });
      })
      .fail(function (data) {
        console.log('error authenticating user with token', token, data)
        Auth.deauthenticateUser();
        window.location = "/signin";
      })
  }

  authenticateWithRequest() {
    let vm = this;
    let $ = window.$;

    $.ajax(
      {
        url: "/me",
        method: 'GET',
        dataType: 'json'
      })
      .done(function (data) {
        window.csrf_token = data.csrf;
        Auth.authenticateUser(data.token, data.user);
        vm.setState({ current_user: data.user });
      })
      .fail(function (data) {
        console.log('error getting user', data);
        Auth.deauthenticateUser();
        window.location = "/signin";
      })
  }

  componentWillMount() {

    EventBus.on('notify:success', (message) => {
      toast.success(message, { autoClose: 5000, position: toast.POSITION.TOP_CENTER })
    });
    EventBus.on('notify:error', (message) => {
      toast.error(message, { autoClose: 10000, position: toast.POSITION.TOP_CENTER })
    });

    if (Auth.isUserAuthenticated()) {
      this.authenticateWithToken(Auth.getToken());
    } else {
      this.authenticateWithRequest();
    }

  }

  isAuthenticated() {
    return Auth.isUserAuthenticated() && this.state && this.state.current_user
  }

  signOut() {
    Auth.deauthenticateUser();
    window.location = "/signout";
  }

  render() {
    const { current } = this.props;

    routes.forEach((route) => {
      if (current === route.path) {
        route.className = 'nav-item active'
      } else {
        route.className = 'nav-item'
      }
    })
    return (
      <div>
        <div className="masthead">
          <div className="container">
            <nav className="nav">
              {current === '/' ? (
                <Link className="nav-item active" to='/'>Home</Link>
              ) : (
                  <Link className="nav-item" to='/'>Home</Link>
                )
              }

              {routes.filter(route => route.type === 'index').map((route, index) => (
                <Link key={route.path} className={route.className} to={route.path}>{route.name}</Link>
              ))
              }

              {this.isAuthenticated() && this.state.current_user ? (
                <div className='nav-item pull-right' onClick={this.signOut}>Sign Out</div>
              ) : (
                  <a className='nav-item pull-right' href='/signin'>Sign In</a>
                )
              }
              {this.isAuthenticated() && this.state.current_user ? (
                <a className='nav-item pull-right' href='/profile'>{this.state.current_user.email}</a>
              ) : (
                  <a className='nav-item pull-right' href='/signup'>Sign Up</a>
                )
              }

            </nav>
          </div>
        </div>

        <ToastContainer />

        <div className="container">
          {this.props.children}
        </div>
      </div>
    );
  }
}
