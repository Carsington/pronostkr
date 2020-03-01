import Sortable from 'sortablejs';

const initSortable = () => {
  const list = document.querySelector('#league-card');
  Sortable.create(list);
};

export { initSortable };
