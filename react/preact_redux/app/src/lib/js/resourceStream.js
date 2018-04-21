import Amber from 'amber';
const EventEmitter = require('event-emitter'); 

import Resource from './resource';

/*
  // example usage
  componentWillMount() {
    this.posts = {};

    let vm = this;

    this.stream = new ResourceStream("post", "http://api.example.com/posts");
    // this.stream = new ResourceStream("post", "/posts");

    this.stream.on('new:model', message => {
      console.log('new post', message.data);
      let post = JSON.parse(message.data);

      vm.posts[post.id] = new Post("/posts", post);
    });

    this.stream.on('update:model', message => {
      console.log('update post', message.data);
      let post = JSON.parse(message.data);

      Object.assign(vm.posts[post.id], post);

      EventBus.emit('update:model:'+post.id, post);
    });

    this.stream.on('delete:model', message => {
      console.log('delete post', message.data);
      let post = JSON.parse(message.data);

      delete vm.posts[post.id];
    });
  }

  componentWillUnmount() {
    this.stream.close();
  }

*/
class ResourceStream  {
  constructor(model_name, endpoint) {

    this.model_name = model_name;
    this.endpoint = endpoint;
    this.resource = new Resource(endpoint);
    this.models = {};

    this.subscribe();
  }

  subscribe() {

    // subscribe to model updates
    // use the EventBus to publish changes to models

    let vm = this;

    vm.socket = new Amber.Socket('/model');
    vm.socket.connect() // returns a promise
      .then(() => {
        // console.log('connecting to model stream for', model_name);
        let channel = vm.socket.channel(vm.model_name);
        channel.join();

        channel.on('update', (message) => {
          // handle new message here
          // console.log('updated model message', message)
          vm.emit('update:model', message);
        });

        channel.on('new', (message) => {
          // handle new message here
          // console.log('new model message', message)
          vm.emit('new:model', message);
        });

        channel.on('delete', (message) => {
          // handle new message here
          // console.log('delete model message', message)
          vm.emit('delete:model', message);
        });

      });
  }

  refresh() {
    // refresh all records

  }

  all() {
    return this.resource.all();
  }

  get(id) {
    return this.resource.get(id);
  }

  add(instance) {
    return this.resource.save_instance(instance);
  }

  destroy(instance) {
    return this.resource.destroy_instance(instance);
  }

  close() {
    if (this.socket) {
      this.socket.disconnect();
      delete this.socket;
    }
  }

}

EventEmitter(ResourceStream.prototype);
export default ResourceStream;
