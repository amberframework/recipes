'use strict';

export const bestTitleForClass = function(item) {
  return item.title || item.name || item.username || item.email || item.id
}

export const titleForId = function(store, id, klazz) {
  if (typeof store.getState()[klazz] === 'undefined') return id;
  let item = store.getState()[klazz].find(el => { return el.id === id})
  return item ? bestTitleForClass(item) : id;
}

export const optionsForClass = function(store, klazz) {
  if (typeof store.getState()[klazz] === 'undefined') return [];
  return store.getState()[klazz].map(item => {
    return {value: item.id, name: bestTitleForClass(item)}
  });
}
