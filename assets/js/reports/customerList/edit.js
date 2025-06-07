// Customer View JavaScript
document.addEventListener('DOMContentLoaded', function() {
    console.log('edit.js loaded');
    
    // Check if we have customer data from PHP
    if (typeof customerData !== 'undefined' && customerData.customer) {
        console.log('Customer data received:', customerData);
    } else {
        console.error('No customer data received from PHP');
    }

    // Get URL parameters to verify the ID is being passed correctly
    const urlParams = new URLSearchParams(window.location.search);
    const customerId = urlParams.get('id');
    console.log('URL parameter ID:', customerId);
    
    // // Add event listeners for buttons in view mode
    document.getElementById('resetButton')?.addEventListener('click', function(e) {
        e.preventDefault();
        window.location.href = 'index.php';
    });
    
    document.getElementById('saveButton')?.addEventListener('click', function(e) {
        e.preventDefault();
        window.location.href = 'edit.php?id=' + customerId;
    });
    
    // Debug elements that should be filled with customer data
    const idField = document.getElementById('id');
    const nameField = document.getElementById('name');
    
    if (idField) {
        console.log('ID field found, value:', idField.value);
    } else {
        console.error('ID field not found');
    }
    
    if (nameField) {
        console.log('Name field found, value:', nameField.value);
    } else {
        console.error('Name field not found');
    }
});