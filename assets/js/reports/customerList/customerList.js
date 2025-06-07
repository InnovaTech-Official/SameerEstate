// DOM Elements - Moving initialization into DOMContentLoaded
let searchInput, cellSearch, cnicSearch, leadFilter, religionFilter;
let maritalStatusFilter, dateFrom, dateTo, resetFiltersBtn, applyFiltersBtn;
let toggleAdvancedSearchBtn, advancedSearch, deleteSelectedBtn;
let selectAllCheckbox, pageSizeSelect, customerTableBody, pageInfo;
let paginationControls, totalCustomerCount;

// Configuration
let config = {
    pageSize: 10,
    currentPage: 1,
    sortColumn: 'name',
    sortDirection: 'asc',
    filters: {
        search: '',
        cellNumber: '',
        cnic: '',
        leadSource: '',
        religion: '',
        maritalStatus: '',
        dateFrom: '',
        dateTo: ''
    }
};

// Store all customers and filtered customers
let allCustomers = [];
let filteredCustomers = [];
let customerCountTimer;

// Initialize the page
document.addEventListener('DOMContentLoaded', function() {
    // Initialize DOM element references
    searchInput = document.getElementById('searchInput');
    cellSearch = document.getElementById('cellSearch');
    cnicSearch = document.getElementById('cnicSearch');
    leadFilter = document.getElementById('leadFilter');
    religionFilter = document.getElementById('religionFilter');
    maritalStatusFilter = document.getElementById('maritalStatusFilter');
    dateFrom = document.getElementById('dateFrom');
    dateTo = document.getElementById('dateTo');
    resetFiltersBtn = document.getElementById('resetFilters');
    applyFiltersBtn = document.getElementById('applyFiltersBtn');
    toggleAdvancedSearchBtn = document.getElementById('toggleAdvancedSearch');
    advancedSearch = document.getElementById('advancedSearch');
    deleteSelectedBtn = document.getElementById('deleteSelectedBtn');
    selectAllCheckbox = document.getElementById('selectAll');
    pageSizeSelect = document.getElementById('pageSizeSelect');
    customerTableBody = document.getElementById('customerTableBody');
    pageInfo = document.getElementById('pageInfo');
    paginationControls = document.getElementById('paginationControls');
    totalCustomerCount = document.getElementById('totalCustomerCount');
    
    // Console log for debugging pagination controls
    console.log('Pagination controls element:', paginationControls);
    
    // Get customer data from PHP
    allCustomers = customerData.customers || [];
    filteredCustomers = [...allCustomers];
    
    // Set default page size if stored in localStorage
    const storedPageSize = localStorage.getItem('customerListPageSize');
    if (storedPageSize && pageSizeSelect) {
        pageSizeSelect.value = storedPageSize;
        config.pageSize = parseInt(storedPageSize);
    }
    
    // Initialize the UI
    initDatePickers();
    populateFilterDropdowns();
    setupEventListeners();
    
    // Initialize tooltips
    $('[data-toggle="tooltip"]').tooltip();
    
    // Update table on initial load
    updateTable();
    
    // Start the live customer count update
    updateCustomerCount();
    startLiveCustomerCount();
});

// Setup Event Listeners
function setupEventListeners() {
    // Search input
    searchInput.addEventListener('input', function() {
        config.filters.search = this.value.trim().toLowerCase();
        config.currentPage = 1; // Reset to first page
        filterCustomers();
    });
    
    // Cell search
    cellSearch.addEventListener('input', function() {
        config.filters.cellNumber = this.value.trim().toLowerCase();
        config.currentPage = 1;
        filterCustomers();
    });
    
    // CNIC search
    cnicSearch.addEventListener('input', function() {
        config.filters.cnic = this.value.trim().toLowerCase();
        config.currentPage = 1;
        filterCustomers();
    });
    
    // Lead filter
    leadFilter.addEventListener('change', function() {
        config.filters.leadSource = this.value;
        config.currentPage = 1;
        filterCustomers();
    });
    
    // Religion filter
    religionFilter.addEventListener('change', function() {
        config.filters.religion = this.value;
        config.currentPage = 1;
        filterCustomers();
    });
    
    // Marital status filter
    maritalStatusFilter.addEventListener('change', function() {
        config.filters.maritalStatus = this.value;
        config.currentPage = 1;
        filterCustomers();
    });
    
    // Date filters
    dateFrom.addEventListener('change', function() {
        config.filters.dateFrom = this.value;
        config.currentPage = 1;
        filterCustomers();
    });
    
    dateTo.addEventListener('change', function() {
        config.filters.dateTo = this.value;
        config.currentPage = 1;
        filterCustomers();
    });
    
    // Reset filters button
    resetFiltersBtn.addEventListener('click', resetFilters);
    
    // Apply filters button
    applyFiltersBtn.addEventListener('click', filterCustomers);
    
    // Toggle advanced search
    toggleAdvancedSearchBtn.addEventListener('click', toggleAdvancedSearch);
    
    // Page size select
    pageSizeSelect.addEventListener('change', function() {
        config.pageSize = parseInt(this.value);
        config.currentPage = 1; // Reset to first page
        updateTable();
    });
    
    // Select all checkbox
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', toggleSelectAll);
    }
    
    // Column visibility events
    document.querySelectorAll('.column-toggle-item input').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            toggleColumnVisibility(this.dataset.column, this.checked);
        });
    });
    
    // Column visibility menu toggle
    document.addEventListener('click', function(event) {
        const dropdown = document.getElementById('columnVisibilityDropdown');
        const toggleButton = event.target.closest('.btn-secondary');
        
        if (!toggleButton && dropdown && dropdown.style.display === 'block' && 
            !dropdown.contains(event.target)) {
            dropdown.style.display = 'none';
        }
    });
}

// Initialize Date Pickers
function initDatePickers() {
    flatpickr('.datepicker', {
        dateFormat: 'Y-m-d'
    });
}

// Populate filter dropdowns with data from PHP
function populateFilterDropdowns() {
    // Populate lead sources
    if (customerData.lookupData && customerData.lookupData.leads) {
        customerData.lookupData.leads.forEach(lead => {
            const option = document.createElement('option');
            option.value = lead.name;
            option.textContent = lead.name;
            leadFilter.appendChild(option);
        });
    }
    
    // Populate religions
    if (customerData.lookupData && customerData.lookupData.religions) {
        customerData.lookupData.religions.forEach(religion => {
            const option = document.createElement('option');
            option.value = religion.name;
            option.textContent = religion.name;
            religionFilter.appendChild(option);
        });
    }
    
    // Populate marital statuses
    if (customerData.lookupData && customerData.lookupData.maritalStatuses) {
        customerData.lookupData.maritalStatuses.forEach(status => {
            const option = document.createElement('option');
            option.value = status.name;
            option.textContent = status.name;
            maritalStatusFilter.appendChild(option);
        });
    }
}

// Filter Customers
function filterCustomers() {
    const filters = config.filters;
    
    filteredCustomers = allCustomers.filter(customer => {
        // Basic search (name, email, company)
        if (filters.search && !(
            (customer.name && customer.name.toLowerCase().includes(filters.search)) ||
            (customer.email && customer.email.toLowerCase().includes(filters.search)) ||
            (customer.company && customer.company.toLowerCase().includes(filters.search))
        )) {
            return false;
        }
        
        // Cell number search
        if (filters.cellNumber && !(
            customer.cell && customer.cell.toLowerCase().includes(filters.cellNumber)
        )) {
            return false;
        }
        
        // CNIC search
        if (filters.cnic && !(
            customer.cnic && customer.cnic.toLowerCase().includes(filters.cnic)
        )) {
            return false;
        }
        
        // Lead source filter
        if (filters.leadSource && customer.lead_name !== filters.leadSource) {
            return false;
        }
        
        // Religion filter
        if (filters.religion && customer.religion_name !== filters.religion) {
            return false;
        }
        
        // Marital status filter
        if (filters.maritalStatus && customer.marital_status !== filters.maritalStatus) {
            return false;
        }
        
        // Date range filters (assuming entry_date is in format DD-MM-YYYY)
        if (filters.dateFrom || filters.dateTo) {
            if (customer.entry_date) {
                // Convert DD-MM-YYYY to YYYY-MM-DD for comparison
                const dateParts = customer.entry_date.split('-');
                const entryDate = new Date(`${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`);
                
                if (filters.dateFrom) {
                    const fromDate = new Date(filters.dateFrom);
                    if (entryDate < fromDate) {
                        return false;
                    }
                }
                
                if (filters.dateTo) {
                    const toDate = new Date(filters.dateTo);
                    if (entryDate > toDate) {
                        return false;
                    }
                }
            } else {
                return false;
            }
        }
        
        return true;
    });
    
    // Reset to first page and update the table
    config.currentPage = 1;
    updateTable();
}

// Update the table with the current page of filtered customers
function updateTable() {
    if (!customerTableBody) return;
    
    // Calculate pagination
    const totalItems = filteredCustomers.length;
    const totalPages = Math.ceil(totalItems / config.pageSize);
    
    // Adjust current page if it's now out of bounds after filtering
    if (config.currentPage > totalPages && totalPages > 0) {
        config.currentPage = totalPages;
    } else if (totalPages === 0) {
        config.currentPage = 1;
    }
    
    const startIndex = (config.currentPage - 1) * config.pageSize;
    const endIndex = Math.min(startIndex + config.pageSize, totalItems);
    
    // Get the current page of customers
    const currentPageCustomers = filteredCustomers.slice(startIndex, endIndex);
    
    // Update page info text
    if (pageInfo) {
        pageInfo.textContent = `Showing ${totalItems > 0 ? startIndex + 1 : 0} to ${endIndex} of ${totalItems} entries`;
    }
    
    // Clear existing table content
    customerTableBody.innerHTML = '';
    
    // Render table rows
    if (currentPageCustomers.length === 0) {
        const row = document.createElement('tr');
        row.innerHTML = '<td colspan="11" class="text-center">No customers found</td>';
        customerTableBody.appendChild(row);
    } else {
        currentPageCustomers.forEach(customer => {
            const row = document.createElement('tr');
            
            // Create cell phone number display (dropdown if multiple numbers)
            let cellDisplay;
            if (customer.all_cell_numbers && customer.all_cell_numbers.length > 1) {
                // Customer has multiple phone numbers - create dropdown
                cellDisplay = `
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="cell-${customer.id}" 
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${customer.cell || 'N/A'} <span class="badge badge-info">${customer.all_cell_numbers.length}</span>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="cell-${customer.id}">
                            ${customer.all_cell_numbers.map(cellNo => 
                                `<a class="dropdown-item" href="tel:${cellNo}">${cellNo}</a>`
                            ).join('')}
                        </div>
                    </div>
                `;
            } else {
                // Customer has only one phone number
                cellDisplay = customer.cell || 'N/A';
            }
            
            // Prepare the image HTML with error handling
            let imageHtml = '<div class="no-image">No Image</div>';
            if (customer.photo_url) {
                imageHtml = `<img src="${customer.photo_url}" alt="${customer.name}" class="customer-image" onerror="this.onerror=null;this.parentNode.innerHTML='<div class=\\'no-image\\'>Image Not Found</div>';">`;
            }
            
            row.innerHTML = `
                <td><input type="checkbox" class="customer-checkbox" data-id="${customer.id}"></td>
                <td class="column-code">${customer.id || ''}</td>
                <td class="column-image">
                    ${imageHtml}
                </td>
                <td class="column-name">${customer.name || ''}</td>
                <td class="column-contact">${cellDisplay}</td>
                <td class="column-email">${customer.email || ''}</td>
                <td class="column-lead">${customer.lead_name || ''}</td>
                <td class="column-religion">${customer.religion_name || ''}</td>
                <td class="column-company">${customer.company || ''}</td>
                <td class="column-entry-date">${customer.entry_date || ''}</td>
                <td>
                    <button class="btn btn-sm btn-view" onclick="viewCustomer(${customer.id})">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-edit" onclick="editCustomer(${customer.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-delete" onclick="deleteCustomer(${customer.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            `;
            
            customerTableBody.appendChild(row);
            
            // Add event listener to checkbox
            const checkbox = row.querySelector('.customer-checkbox');
            checkbox.addEventListener('change', updateDeleteSelectedButton);
        });
    }
    
    // Update pagination
    updatePagination(totalPages);
    
    // Apply column visibility preferences
    loadColumnPreferences();
    
    // Log pagination state for debugging
    console.log('Pagination state:', {
        totalItems,
        totalPages,
        currentPage: config.currentPage,
        pageSize: config.pageSize,
        startIndex,
        endIndex,
        visibleItems: currentPageCustomers.length
    });
}

// Update pagination controls
function updatePagination(totalPages) {
    if (!paginationControls) {
        console.error('Pagination controls element not found!');
        return;
    }
    
    console.log('Creating pagination for', totalPages, 'pages, current page:', config.currentPage);
    
    // Clear existing pagination
    paginationControls.innerHTML = '';
    
    // If no pages or only one page, don't show pagination
    if (totalPages <= 1) {
        console.log('Not showing pagination for only', totalPages, 'page(s)');
        paginationControls.style.display = 'none';
        return;
    } else {
        paginationControls.style.display = 'block';
    }
    
    // Create "Previous" button
    const prevLi = document.createElement('li');
    prevLi.className = `page-item ${config.currentPage === 1 ? 'disabled' : ''}`;
    
    const prevLink = document.createElement('a');
    prevLink.className = 'page-link';
    prevLink.href = '#';
    prevLink.setAttribute('aria-label', 'Previous');
    prevLink.innerHTML = 'Previous';
    
    if (config.currentPage > 1) {
        prevLink.addEventListener('click', function(e) {
            e.preventDefault();
            config.currentPage--;
            updateTable();
        });
    }
    
    prevLi.appendChild(prevLink);
    paginationControls.appendChild(prevLi);
    
    // Google/Gmail style pagination
    // Show at most 7 page numbers with dots for omitted ranges
    const maxVisiblePages = 7;
    let startPage, endPage;
    
    if (totalPages <= maxVisiblePages) {
        // If we have 7 or fewer pages, show all pages
        startPage = 1;
        endPage = totalPages;
    } else {
        // We have more than 7 pages, calculate which ones to show
        if (config.currentPage <= 3) {
            // Current page is among the first 3 pages
            startPage = 1;
            endPage = 5;
        } else if (config.currentPage + 2 >= totalPages) {
            // Current page is among the last 3 pages
            startPage = totalPages - 4;
            endPage = totalPages;
        } else {
            // Current page is in the middle
            startPage = config.currentPage - 2;
            endPage = config.currentPage + 2;
        }
    }
    
    // Add first page + ellipsis if needed
    if (startPage > 1) {
        const firstLi = document.createElement('li');
        firstLi.className = 'page-item';
        
        const firstLink = document.createElement('a');
        firstLink.className = 'page-link';
        firstLink.href = '#';
        firstLink.textContent = '1';
        
        firstLink.addEventListener('click', function(e) {
            e.preventDefault();
            config.currentPage = 1;
            updateTable();
        });
        
        firstLi.appendChild(firstLink);
        paginationControls.appendChild(firstLi);
        
        if (startPage > 2) {
            const ellipsisLi = document.createElement('li');
            ellipsisLi.className = 'page-item disabled';
            
            const ellipsisSpan = document.createElement('span');
            ellipsisSpan.className = 'page-link';
            ellipsisSpan.innerHTML = '&hellip;';
            
            ellipsisLi.appendChild(ellipsisSpan);
            paginationControls.appendChild(ellipsisLi);
        }
    }
    
    // Add page numbers
    for (let i = startPage; i <= endPage; i++) {
        const pageLi = document.createElement('li');
        pageLi.className = `page-item ${i === config.currentPage ? 'active' : ''}`;
        
        const pageLink = document.createElement('a');
        pageLink.className = 'page-link';
        pageLink.href = '#';
        pageLink.textContent = i;
        
        pageLink.addEventListener('click', function(e) {
            e.preventDefault();
            config.currentPage = i;
            updateTable();
        });
        
        pageLi.appendChild(pageLink);
        paginationControls.appendChild(pageLi);
    }
    
    // Add last page + ellipsis if needed
    if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
            const ellipsisLi = document.createElement('li');
            ellipsisLi.className = 'page-item disabled';
            
            const ellipsisSpan = document.createElement('span');
            ellipsisSpan.className = 'page-link';
            ellipsisSpan.innerHTML = '&hellip;';
            
            ellipsisLi.appendChild(ellipsisSpan);
            paginationControls.appendChild(ellipsisLi);
        }
        
        const lastLi = document.createElement('li');
        lastLi.className = 'page-item';
        
        const lastLink = document.createElement('a');
        lastLink.className = 'page-link';
        lastLink.href = '#';
        lastLink.textContent = totalPages;
        
        lastLink.addEventListener('click', function(e) {
            e.preventDefault();
            config.currentPage = totalPages;
            updateTable();
        });
        
        lastLi.appendChild(lastLink);
        paginationControls.appendChild(lastLi);
    }
    
    // Create "Next" button
    const nextLi = document.createElement('li');
    nextLi.className = `page-item ${config.currentPage === totalPages ? 'disabled' : ''}`;
    
    const nextLink = document.createElement('a');
    nextLink.className = 'page-link';
    nextLink.href = '#';
    nextLink.setAttribute('aria-label', 'Next');
    nextLink.innerHTML = 'Next';
    
    if (config.currentPage < totalPages) {
        nextLink.addEventListener('click', function(e) {
            e.preventDefault();
            config.currentPage++;
            updateTable();
        });
    }
    
    nextLi.appendChild(nextLink);
    paginationControls.appendChild(nextLi);
    
    console.log('Pagination created successfully');
}

// Update the page information text
function updatePageInfo(start, end, total) {
    if (pageInfoElement) {
        pageInfoElement.textContent = `Showing ${start} to ${end} of ${total} entries`;
    }
}

// Render the customer table with data
function renderCustomerTable(customers) {
    if (!customerTableBody) {
        console.error('Customer table body element not found!');
        return;
    }
    
    // Clear existing table rows
    customerTableBody.innerHTML = '';
    
    // If no customers, show a message
    if (!customers || customers.length === 0) {
        const emptyRow = document.createElement('tr');
        const emptyCell = document.createElement('td');
        emptyCell.colSpan = 11; // Adjust based on your number of columns
        emptyCell.textContent = 'No customers found';
        emptyCell.className = 'text-center';
        emptyRow.appendChild(emptyCell);
        customerTableBody.appendChild(emptyRow);
        return;
    }
    
    // Render each customer row
    customers.forEach(customer => {
        // Create table row elements here
        // ... (existing customer row creation code) ...
    });
}

// Toggle Advanced Search
function toggleAdvancedSearch() {
    if (advancedSearch.style.display === 'none' || advancedSearch.style.display === '') {
        advancedSearch.style.display = 'block';
        toggleAdvancedSearchBtn.innerHTML = '<i class="fas fa-times"></i> Hide Advanced Search';
    } else {
        advancedSearch.style.display = 'none';
        toggleAdvancedSearchBtn.innerHTML = '<i class="fas fa-filter"></i> Advanced Search';
    }
}

// Toggle Column Visibility Menu
function toggleColumnVisibilityMenu() {
    const dropdown = document.getElementById('columnVisibilityDropdown');
    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
}

// Toggle Column Visibility
function toggleColumnVisibility(column, visible) {
    const cells = document.querySelectorAll(`.column-${column}`);
    cells.forEach(cell => {
        if (visible) {
            cell.classList.remove('hidden-column');
        } else {
            cell.classList.add('hidden-column');
        }
    });
    
    // Save preferences to local storage
    const columnPreferences = JSON.parse(localStorage.getItem('columnPreferences') || '{}');
    columnPreferences[column] = visible;
    localStorage.setItem('columnPreferences', JSON.stringify(columnPreferences));
}

// Load column visibility preferences
function loadColumnPreferences() {
    const columnPreferences = JSON.parse(localStorage.getItem('columnPreferences') || '{}');
    
    Object.keys(columnPreferences).forEach(column => {
        const checkbox = document.querySelector(`input[data-column="${column}"]`);
        if (checkbox) {
            checkbox.checked = columnPreferences[column];
        }
        toggleColumnVisibility(column, columnPreferences[column]);
    });
}

// Reset Filters
function resetFilters() {
    // Clear all filter inputs
    searchInput.value = '';
    cellSearch.value = '';
    cnicSearch.value = '';
    leadFilter.value = '';
    religionFilter.value = '';
    maritalStatusFilter.value = '';
    dateFrom.value = '';
    dateTo.value = '';
    
    // Reset filter config
    config.filters = {
        search: '',
        cellNumber: '',
        cnic: '',
        leadSource: '',
        religion: '',
        maritalStatus: '',
        dateFrom: '',
        dateTo: ''
    };
    
    // Reset page to 1
    config.currentPage = 1;
    
    // Reset filtered customers to all customers
    filteredCustomers = [...allCustomers];
    
    // Update the table
    updateTable();
}

// Toggle Select All
function toggleSelectAll() {
    const isChecked = selectAllCheckbox.checked;
    const checkboxes = document.querySelectorAll('.customer-checkbox');
    
    checkboxes.forEach(checkbox => {
        checkbox.checked = isChecked;
    });
    
    updateDeleteSelectedButton();
}

// Update Delete Selected Button
function updateDeleteSelectedButton() {
    const checkboxes = document.querySelectorAll('.customer-checkbox:checked');
    
    if (checkboxes.length > 0) {
        deleteSelectedBtn.style.display = 'inline-flex';
        deleteSelectedBtn.innerHTML = `<i class="fas fa-trash"></i> Delete Selected (${checkboxes.length})`;
    } else {
        deleteSelectedBtn.style.display = 'none';
    }
}

// Delete Selected Customers
function deleteSelectedCustomers() {
    const selectedIds = Array.from(document.querySelectorAll('.customer-checkbox:checked'))
        .map(checkbox => checkbox.dataset.id);
    
    if (selectedIds.length === 0) return;
    
    Swal.fire({
        title: 'Are you sure?',
        text: `You are about to delete ${selectedIds.length} customer(s). This cannot be undone!`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, delete them!'
    }).then((result) => {
        if (result.isConfirmed) {
            // Make an AJAX call to delete the customers
            $.ajax({
                url: '../../../controllers/customers/deleteMultiple.php',
                type: 'POST',
                data: { ids: selectedIds },
                success: function(response) {
                    try {
                        const result = JSON.parse(response);
                        if (result.success) {
                            Swal.fire(
                                'Deleted!',
                                `${selectedIds.length} customer(s) have been deleted.`,
                                'success'
                            ).then(() => {
                                // Remove deleted customers from the arrays
                                selectedIds.forEach(id => {
                                    allCustomers = allCustomers.filter(c => c.id !== id);
                                });
                                filteredCustomers = filteredCustomers.filter(c => !selectedIds.includes(c.id));
                                
                                // Update the table
                                updateTable();
                            });
                        } else {
                            Swal.fire(
                                'Error!',
                                result.message || 'There was a problem deleting the customers.',
                                'error'
                            );
                        }
                    } catch (e) {
                        Swal.fire(
                            'Error!',
                            'There was a problem processing the server response.',
                            'error'
                        );
                    }
                },
                error: function() {
                    Swal.fire(
                        'Error!',
                        'There was a problem connecting to the server.',
                        'error'
                    );
                }
            });
        }
    });
}

// View Customer
function viewCustomer(id) {
    // Ensure id is an integer
    const customerId = parseInt(id, 10);
    
    // Log for debugging
    console.log("Viewing customer with ID:", customerId);
    
    // Add the ID as a query parameter to the URL and redirect
    window.location.href = `view.php?id=${id}`;
}

// Edit Customer
function editCustomer(id) {
    window.location.href = `edit.php?id=${id}`;
}

// Delete Customer
function deleteCustomer(id) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading state
            Swal.fire({
                title: 'Deleting...',
                text: 'Please wait while we delete this customer',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
            
            // Make an AJAX call to delete the customer
            $.ajax({
                url: '../../../models/reports/customerList/delete.php',
                type: 'POST',
                data: { id: id },
                success: function(response) {
                    try {
                        const result = typeof response === 'string' ? JSON.parse(response) : response;
                        
                        if (result.success) {
                            Swal.fire({
                                title: 'Deleted!',
                                text: 'Customer has been deleted.',
                                icon: 'success',
                                timer: 2000,
                                showConfirmButton: false
                            }).then(() => {
                                // Remove the deleted customer from arrays
                                allCustomers = allCustomers.filter(c => c.id != id);
                                filteredCustomers = filteredCustomers.filter(c => c.id != id);
                                
                                // Update the table
                                updateTable();
                            });
                        } else {
                            Swal.fire(
                                'Error!',
                                result.message || 'There was a problem deleting the customer.',
                                'error'
                            );
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e, response);
                        Swal.fire(
                            'Error!',
                            'There was a problem processing the server response.',
                            'error'
                        );
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX error:', error, xhr.responseText);
                    Swal.fire(
                        'Error!',
                        'There was a problem connecting to the server: ' + error,
                        'error'
                    );
                }
            });
        }
    });
}

// Print List
function printList() {
    window.print();
}

// Export to PDF
function exportToPDF() {
    Swal.fire({
        title: 'Exporting PDF',
        text: 'Your PDF is being generated...',
        allowOutsideClick: false,
        showConfirmButton: false,
        willOpen: () => {
            Swal.showLoading();
            
            // Create a form with the current filtered data
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '../../../controllers/reports/customerList/exportPdf.php';
            form.target = '_blank';
            
            // Add a hidden field with the filtered customer IDs
            const customerIds = filteredCustomers.map(c => c.id);
            const hiddenField = document.createElement('input');
            hiddenField.type = 'hidden';
            hiddenField.name = 'customerIds';
            hiddenField.value = JSON.stringify(customerIds);
            form.appendChild(hiddenField);
            
            // Add search parameters to the form
            const searchParams = document.createElement('input');
            searchParams.type = 'hidden';
            searchParams.name = 'searchParams';
            searchParams.value = JSON.stringify(config.filters);
            form.appendChild(searchParams);
            
            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);
            
            setTimeout(() => {
                Swal.close();
            }, 1000);
        }
    });
}

// Update Customer Count
function updateCustomerCount() {
    if (totalCustomerCount) {
        // First update with initial count from the server
        totalCustomerCount.textContent = `Total: ${customerData.totalCustomers || 0}`;
    }
}

// Start Live Customer Count Update
function startLiveCustomerCount() {
    // Update every 1 second (1000ms)
    customerCountTimer = setInterval(() => {
        // Fetch the latest count from the server with full path
        fetch('../../../models/reports/customerList/count.php', {
            method: 'GET',
            headers: {
                'Cache-Control': 'no-cache'
            },
            credentials: 'same-origin'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.success && totalCustomerCount) {
                    totalCustomerCount.textContent = `Total: ${data.total_customers}`;
                }
            })
            .catch(error => {
                console.error('Error fetching customer count:', error);
                // Stop trying to fetch if there's an error to prevent console spam
                clearInterval(customerCountTimer);
            });
    }, 5000); // Changed to 5 seconds to reduce server load
}

// Stop Live Customer Count Update
function stopLiveCustomerCount() {
    clearInterval(customerCountTimer);
}