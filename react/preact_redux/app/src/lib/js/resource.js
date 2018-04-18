import EventBus from './eventBus';

import Auth from './auth';

export default class Resource {
  constructor(endpoint, attributes) {

    this.endpoint = endpoint;

    if (attributes) {
      Object.assign(this, attributes);
    }

  }

  all() {
    let $ = window.$;

    return  $.ajax(
      {
        url: this.endpoint,
        method: 'GET',
        dataType: 'json'
      });
  }

  save_instance(instance) {
    let url = this.endpoint;
    let method = 'POST';
    let $ = window.$;

    // create a clone of this object with only the source attributes
    let clone = {};
    Object.assign(clone, instance);
    delete clone.endpoint;

    if (instance.id) {
      url = this.endpoint+'/'+instance.id;;
      method = 'PUT';
      clone._method = 'patch';
    }

    // inject my user_id in case the model requires it
    if (typeof clone.user_id === 'undefined' && Auth.isUserAuthenticated()) {
      let user = Auth.getUser();
      clone.user_id = user.id;
    }

    console.log('saving instance', clone)

    return  $.ajax(
      {
        url: url,
        method: method,
        headers: {
          "X-CSRF-TOKEN": window.csrf_token
        },
        dataType: 'json',
        data: clone
      });
  }

  destroy_instance(instance) {
    let url = this.endpoint+'/'+instance.id;;
    let $ = window.$;

    return $.ajax(
      {
        url: url,
        method: 'DELETE',
        headers: {
          "X-CSRF-TOKEN": window.csrf_token
        },
        dataType: 'json',
      });
  }

  get(id) {
    let url = this.endpoint+'/'+id;
    let $ = window.$;

    return $.ajax(
      {
        url: url,
        method: 'GET',
        dataType: 'json'
      });
  }

  save() {
    return this.save_instance(this);
  }

  destroy() {
    return this.destroy_instance(this);
  }
}
