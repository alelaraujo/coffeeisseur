import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';
import { showMarkers } from '../plugins/init_mapbox';

const renderItem = function({ name, city, street }) {
  const icon = '<i class="fas fa-map-marker-alt"></i>';

  return `<div class="autocomplete-suggestion" data-name="${name}">${icon}<span>${name}</span> || ${street} || ${city}</div>`
};

const autocompleteSearch = function() {
  const places = JSON.parse(document.getElementById('search-data').dataset.places)
  const searchInput = document.getElementById('query');

  // On page load show markers!
  window.onload = (e) => {
    $.getJSON('/autocomplete.json',
      { query: searchInput.value },
      function(data) {
        //console.log(data)
        showMarkers(data);
        return data;
      })
  }

  if (places && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 2,
      onSelect: (event, term, item) => {
        searchInput.value = item.dataset.name;
      },
      source: function(term, suggest) {
        $.getJSON('/autocomplete.json',
          { query: term },
          function(data) {
            return data;
        }).then((data) => {
          const matches = []
          data.forEach((place) => {
            matches.push(place);
          });
          suggest(matches);
          showMarkers(data);
        });
      },
      renderItem: renderItem,
    });
  }
};

export { autocompleteSearch };

// Search only by name!
// const autocompleteSearch = function() {
//   const places = JSON.parse(document.getElementById('search-data').dataset.places)
//   const searchInput = document.getElementById('query');

//   if (places && searchInput) {
//     new autocomplete({
//       selector: searchInput,
//       minChars: 1,
//       source: function(term, suggest){
//           term = term.toLowerCase();
//           const choices = places;
//           const matches = [];
//           for (let i = 0; i < choices.length; i++)
//               if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
//           suggest(matches);
//       },
//     });
//   }
// };

