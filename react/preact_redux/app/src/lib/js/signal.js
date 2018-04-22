import Amber from 'amber';
import EventBus from './eventBus';

/*
  // example usage
  this.signals = {};

  let vm = this;

  this.stream = new Signal();
  this.stream.subscribe("FTSE100");  // subscribe to signals about FTSE100

  EventBus.on('new:signal', message => {
    console.log('new signal', message.data);
    let signal = JSON.parse(message.data);

    vm.signal[signal.id] = signal;
  });

  componentWillUnmount() {
    this.stream.close();
  }

*/
export default class Signal {

  subscribe(topic) {

    // subscribe to signals for a given topic
    // use the EventBus to publish signals

    let vm = this;

    vm.signal_socket = new Amber.Socket('/signal');
    vm.signal_socket.connect() // returns a promise
      .then(() => {
        // console.log('connecting to signal stream for', topic);
        let channel = vm.signal_socket.channel(topic);
        channel.join();

        channel.on('new', (message) => {
          // handle new message here
          // console.log('new signal message', message)
          EventBus.emit('new:signal', message);
        });

      });
  }

  close() {
    if (this.signal_socket) {
      this.signal_socket.disconnect();
      delete this.signal_socket;
    }
  }

}
