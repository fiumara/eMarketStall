document.addEventListener('DOMContentLoaded', function() {
    // Seleziona l'elemento del menu a discesa
    var user_type = document.getElementById('user_typet');
  
    // Aggiungi un event listener per l'evento di cambio nel menu a discesa
    user_type.addEventListener('change', function() {
      // Ottieni il valore selezionato
      var selectedValue = user_type.value;
  
      // Esegui un'azione in base al valore selezionato
      if (selectedValue === 'all') {
        showAllAccounts();
      } else {
        filterAccountsByType(selectedValue);
      }
    });
  
    // Funzione per mostrare tutti gli account
    function showAllAccounts() {
      var accountBoxes = document.querySelectorAll('.account-box');
      accountBoxes.forEach(function(box) {
        box.style.display = 'flex';
      });
    }
  
    // Funzione per filtrare gli account per tipo
    function filterAccountsByType(userType) {
      var accountBoxes = document.querySelectorAll('.account-box');
      accountBoxes.forEach(function(box) {
        box.style.display = 'none';
      });
  
      var filteredBoxes = document.querySelectorAll('.account-box[data-tipo="' + userType + '"]');
      filteredBoxes.forEach(function(box) {
        box.style.display = 'flex';
      });
    }
  });
  