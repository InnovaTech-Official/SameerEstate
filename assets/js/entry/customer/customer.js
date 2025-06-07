// Main document ready function
        $(document).ready(function() {
            // Initialize service worker for caching
            initializeServiceWorker();
            
            // Initialize controller connection
            initializeControllerConnection();
            
            // Initialize Select2 for all select elements
            $('select').select2({
                width: '100%',
                placeholder: 'Select an option',
                allowClear: true
            });
            
            // Special initialization for Zodiac sign select with custom formatting
            $('#star').select2({
                templateResult: formatZodiacOption,
                templateSelection: formatZodiacOption
            });
            
            // Initialize tabs functionality
            initializeTabs();
            
            // Initialize cell number fields
            initializeCellNumberFields();
            
            // Initialize IBAN fields
            initializeIBANFields();
            
            // Initialize DOB to Zodiac conversion
            initializeDOBZodiacConversion();
            
            // Setup dependent dropdowns (Country -> City -> Area)
            setupDependentDropdowns();
            
            // Load initial data for all lookup dropdowns
            ['leads', 'casts', 'religions', 'marital_statuses', 'countries', 'occupations', 'bank'].forEach(table => {
                loadLookupData(table);
            });
            
            // Setup event handlers
            setupEventHandlers();
            
            // Setup periodic ID refreshing to prevent conflicts
            setupPeriodicIdRefresh();
            
            // Load cached form data if available
            loadCachedFormData();
            
            // Setup form auto-save
            setupFormAutoSave();
        });
        
        // Show alert using SweetAlert2
        function showAlert(icon, title, text) {
            Swal.fire({
                icon: icon, // 'success', 'error', 'warning', 'info', 'question'
                title: title,
                text: text,
                confirmButtonText: 'OK',
                confirmButtonColor: '#3085d6'
            });
        }
        
        // Initialize service worker for caching
        function initializeServiceWorker() {
            if ('serviceWorker' in navigator) {
                window.addEventListener('load', () => {
                    navigator.serviceWorker.register('/realestate/assets/js/sw.js')
                        .then(registration => {
                            console.log('ServiceWorker registration successful with scope: ', registration.scope);
                        })
                        .catch(error => {
                            console.error('ServiceWorker registration failed: ', error);
                        });
                });
            }
        }
        
        // Initialize controller connection
        function initializeControllerConnection() {
            // Set customer ID from PHP controller if available
            if (typeof newCustomerCode !== 'undefined') {
                $('#id').val(newCustomerCode);
            } else {
                // If not directly available, request it via AJAX
                fetchCustomerId();
            }
            
            // Listen for controller messages
            window.addEventListener('message', function(event) {
                if (event.data && event.data.type) {
                    handleControllerMessage(event.data);
                }
            });
        }

        // Handle messages from controller
        function handleControllerMessage(message) {
            switch(message.type) {
                case 'updateCustomerCode':
                    $('#id').val(message.code);
                    break;
                case 'refreshData':
                    resetForm();
                    loadAllLookupData();
                    break;
                case 'showAlert':
                    showAlert(message.icon, message.title, message.text);
                    break;
                case 'formSubmitResult':
                    handleFormSubmitResult(message.data);
                    break;
            }
        }

        // Fetch customer ID from controller
        function fetchCustomerId() {
            $.ajax({
                url: '?action=get_next_code',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        $('#id').val(response.code);
                    } else {
                        showAlert('error', 'Error', 'Failed to get customer ID');
                    }
                },
                error: function(xhr) {
                    showAlert('error', 'Error', 'Failed to connect to server');
                }
            });
        }

        // Send message to controller
        function sendToController(message) {
            // For direct AJAX communication
            if (message.type === 'formSubmit') {
                submitFormToController(message.formData);
            } else {
                // For other types of messages
                $.ajax({
                    url: window.location.href,
                    type: 'POST',
                    data: {
                        action: 'handleMessage',
                        message: JSON.stringify(message)
                    },
                    success: function(response) {
                        try {
                            if (typeof response === 'string') {
                                response = JSON.parse(response);
                            }
                            
                            if (response.success) {
                                if (response.callback) {
                                    handleControllerMessage(response.callback);
                                }
                            } else {
                                showAlert('error', 'Error', response.error || 'Unknown error');
                            }
                        } catch (e) {
                            console.error('Error processing response:', e);
                        }
                    },
                    error: function(xhr) {
                        showAlert('error', 'Connection Error', 'Failed to communicate with server');
                    }
                });
            }
        }

        // Submit form to controller
        function submitFormToController(formData) {
            const saveButton = $('#saveButton');
            saveButton.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Saving...');
            
            $.ajax({
                url: window.location.href,
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    try {
                        if (typeof response === 'string') {
                            // Check if the response contains both an error and success message concatenated
                            if (response.includes('{"success":false') && response.includes('{"success":true')) {
                                console.log("Detected concatenated response with both error and success");
                                
                                // Extract the success part of the response
                                const successMatch = response.match(/(\{"success":true[^}]+\})/);
                                if (successMatch && successMatch[1]) {
                                    try {
                                        const successResponse = JSON.parse(successMatch[1]);
                                        handleFormSubmitResult(successResponse);
                                        return;
                                    } catch (e) {
                                        console.error("Failed to parse success part:", e);
                                    }
                                }
                            }
                            
                            response = JSON.parse(response);
                        }
                        
                        handleFormSubmitResult(response);
                    } catch (error) {
                        console.error("Error parsing response:", error);
                        console.log("Original response:", response);
                        
                        // If we get here, try to extract any useful information from the response
                        if (typeof response === 'string' && response.includes('{"success":true')) {
                            // The response contains a success message somewhere, treat it as success
                            showAlert('success', 'Success', 'Customer saved successfully!');
                            fetchCustomerId();
                            clearFormCache();
                            resetForm();
                            return;
                        }
                        
                        showAlert('error', 'Error', 'An unexpected error occurred. Please try again.');
                        saveButton.prop('disabled', false).html('<i class="fas fa-save"></i> Save');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error response:", xhr.responseText);
                    
                    // Check if the response contains both an error and success message
                    let responseText = xhr.responseText || '';
                    
                    if (responseText.includes('{"success":true')) {
                        // Extract the success part and treat it as a success
                        try {
                            const successMatch = responseText.match(/(\{"success":true[^}]+\})/);
                            if (successMatch && successMatch[1]) {
                                const successResponse = JSON.parse(successMatch[1]);
                                handleFormSubmitResult(successResponse);
                                return;
                            }
                        } catch (e) {
                            console.error("Failed to extract success part:", e);
                        }
                        
                        // Even if parsing fails, if we detected a success message, treat it as success
                        showAlert('success', 'Success', 'Customer saved successfully!');
                        fetchCustomerId();
                        clearFormCache();
                        resetForm();
                        return;
                    }
                    
                    // Regular error handling
                    let errorMessage = 'Failed to save customer. Please try again.';

                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response && response.error) {
                            errorMessage = response.error;
                        }
                    } catch (e) {
                        if (xhr.status === 403) {
                            errorMessage = 'You do not have permission to perform this action.';
                        } else if (xhr.responseText) {
                            errorMessage = 'Error: ' + xhr.responseText.substring(0, 100);
                            if (xhr.responseText.length > 100) errorMessage += '...';
                        }
                    }

                    showAlert('error', 'Error', errorMessage);
                    saveButton.prop('disabled', false).html('<i class="fas fa-save"></i> Save');
                }
            });
        }

        // Function to populate form with customer data
function populateForm(customerData) {
    if (!customerData) return;
    
    // Debug log
    debug('Populating form with customer data:', customerData);
    
    // Basic fields
    for (const key in customerData) {
        const element = document.getElementById(key);
        if (element && customerData[key] !== null) {
            if (element.tagName === 'INPUT' || element.tagName === 'TEXTAREA') {
                element.value = customerData[key];
            } else if (element.tagName === 'SELECT') {
                $(element).val(customerData[key]).trigger('change');
            }
        }
    }
    
    // Map specific fields for dropdowns using _id convention
    const fieldMapping = {
        'lead_id': 'leads_id',
        'city_id': 'cities_id',
        'area_id': 'areas_id',
        'cast_id': 'casts_id',
        'religion_id': 'religions_id',
        'marital_status_id': 'marital_statuses_id',
        'country_id': 'countries_id',
        'occupation': 'occupations_id'
    };
    
    // Set values for mapped fields
    for (const key in fieldMapping) {
        if (customerData[key] !== null && customerData[key] !== undefined) {
            const element = document.getElementById(fieldMapping[key]);
            if (element) {
                $(element).val(customerData[key]).trigger('change');
            }
        }
    }
    
    // Handle primary cell phone
    if (customerData.cell) {
        $('#cell').val(customerData.cell);
    }
    
    // Handle additional cell numbers
    if (customerData.additional_cell && customerData.additional_cell.length > 0) {
        const container = document.getElementById("cell-numbers-container");
        
        customerData.additional_cell.forEach(cellNumber => {
            const newInput = document.createElement("div");
            newInput.className = "input-group mb-2";
            newInput.innerHTML = `
                <input type="tel" class="form-control" name="additional_cell[]" value="${cellNumber}" placeholder="Additional cell number">
                <div class="input-group-append">
                    <button type="button" class="btn btn-success btn-add-cell">
                        <i class="fas fa-plus"></i>
                    </button>
                    <button type="button" class="btn btn-danger btn-remove-cell">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            `;
            container.appendChild(newInput);
        });
    }
    
    // Handle bank information - primary bank and IBAN
    if (customerData.bank_id) {
        $('#bank_id').val(customerData.bank_id).trigger('change');
    }
    
    if (customerData.account_iban) {
        $('#account_iban').val(customerData.account_iban);
    }
    
    // Handle additional bank information
    if (customerData.additional_banks && customerData.additional_banks.length > 0) {
        const bankContainer = document.getElementById("bank-container");
        const ibanContainer = document.getElementById("iban-container");
        
        customerData.additional_banks.forEach(bank => {
            // Add additional bank field
            if (bankContainer) {
                const newBankInput = document.createElement("div");
                newBankInput.className = "input-group mb-2";
                newBankInput.innerHTML = `
                    <select class="form-control additional-bank" name="additional_bank_id[]">
                        <option value="">Select Bank</option>
                    </select>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-success btn-add-lookup" data-table="bank">
                            <i class="fas fa-plus"></i>
                        </button>
                        <button type="button" class="btn btn-danger btn-remove-bank">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                `;
                bankContainer.appendChild(newBankInput);
                
                // Initialize Select2 for the new bank dropdown
                const select = $(newBankInput.querySelector('select'));
                select.select2({
                    width: '100%',
                    placeholder: 'Select an option',
                    allowClear: true
                });
                
                // Load bank data and set the selected bank
                $.ajax({
                    url: '../../../models/entry/customer/fetch.php',
                    type: 'GET',
                    data: { table: 'bank' },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success && response.data) {
                            response.data.forEach(item => {
                                select.append(new Option(item.name, item.id));
                            });
                            
                            // Find the bank ID that matches the bank name
                            const bankId = response.data.find(item => item.name === bank.bank_name)?.id;
                            if (bankId) {
                                select.val(bankId).trigger('change');
                            }
                        }
                    }
                });
            }
            
            // Add additional IBAN field
            if (ibanContainer) {
                const newIbanInput = document.createElement("div");
                newIbanInput.className = "input-group mb-2";
                newIbanInput.innerHTML = `
                    <input type="text" class="form-control" name="additional_iban[]" value="${bank.iban}" placeholder="Additional IBAN">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-success btn-add-iban">
                            <i class="fas fa-plus"></i>
                        </button>
                        <button type="button" class="btn btn-danger btn-remove-iban">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                `;
                ibanContainer.appendChild(newIbanInput);
            }
        });
    }
    
    // Handle file previews
    if (customerData.files) {
        for (const fileType in customerData.files) {
            let previewId;
            
            switch (fileType) {
                case 'photo':
                    previewId = 'preview-image';
                    break;
                case 'cnic_front':
                    previewId = 'cnic-front-preview';
                    break;
                case 'cnic_back':
                    previewId = 'cnic-back-preview';
                    break;
                case 'visiting_card':
                    previewId = 'visiting-card-preview-image';
                    break;
            }
            
            if (previewId) {
                document.getElementById(previewId).src = customerData.files[fileType];
                document.getElementById(previewId).closest('.picture-preview').querySelector('.picture-overlay').style.display = 'none';
            }
        }
    }
}

        // Load all lookup data
        function loadAllLookupData() {
            ['leads', 'cities', 'casts', 'religions', 'areas', 'marital_statuses', 'countries', 'occupations', 'bank'].forEach(table => {
                loadLookupData(table);
            });
        }

        // Debug helper function
        function debug(message, data) {
            console.log(`[DEBUG] ${message}:`, data);
        }

        // Initialize tabs functionality
        function initializeTabs() {
            const tabLinks = document.querySelectorAll('#customerTabs a');
            tabLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();

                    // Hide all tab panes first
                    document.querySelectorAll('.tab-pane').forEach(pane => {
                        pane.classList.remove('show', 'active');
                    });

                    // Remove active class from all tabs
                    tabLinks.forEach(tabLink => {
                        tabLink.classList.remove('active');
                        tabLink.setAttribute('aria-selected', 'false');
                    });

                    // Set the clicked tab as active
                    this.classList.add('active');
                    this.setAttribute('aria-selected', 'true');

                    // Show the corresponding tab content
                    const targetId = this.getAttribute('href');
                    const targetPane = document.querySelector(targetId);
                    if (targetPane) {
                        targetPane.classList.add('show', 'active');
                    }
                });
            });
        }

        // Initialize cell number fields
        function initializeCellNumberFields() {
            const maxCells = 5;
            const container = document.getElementById("cell-numbers-container");

            if (container) {
                container.addEventListener("click", function(e) {
                    if (e.target.closest(".btn-add-cell")) {
                        const inputs = container.querySelectorAll(".input-group");
                        if (inputs.length < maxCells) {
                            const newInput = document.createElement("div");
                            newInput.className = "input-group mb-2";
                            newInput.innerHTML = `
                                <input type="tel" class="form-control" name="additional_cell[]" placeholder="Additional cell number">
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-success btn-add-cell">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                    <button type="button" class="btn btn-danger btn-remove-cell">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            `;
                            container.appendChild(newInput);
                        } else {
                            showAlert('warning', 'Maximum Reached', 'Maximum 5 cell numbers allowed.');
                        }
                    }

                    if (e.target.closest(".btn-remove-cell")) {
                        const inputs = container.querySelectorAll(".input-group");
                        if (inputs.length > 1) {
                            e.target.closest(".input-group").remove();
                        } else {
                            // Don't remove the last cell number input, just clear it
                            inputs[0].querySelector("input").value = "";
                        }
                    }
                });
            }
        }
        
        // Initialize IBAN fields
        function initializeIBANFields() {
            const maxIbans = 5;
            const container = document.getElementById("iban-container");
            const bankContainer = document.getElementById("bank-container");

            if (container) {
                container.addEventListener("click", function(e) {
                    if (e.target.closest(".btn-add-iban")) {
                        const inputs = container.querySelectorAll(".input-group");
                        if (inputs.length < maxIbans) {
                            // Add new IBAN field
                            const newInput = document.createElement("div");
                            newInput.className = "input-group mb-2";
                            newInput.innerHTML = `
                                <input type="text" class="form-control" name="additional_iban[]" placeholder="Additional IBAN">
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-success btn-add-iban">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                    <button type="button" class="btn btn-danger btn-remove-iban">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            `;
                            container.appendChild(newInput);
                            
                            // Add corresponding Bank dropdown
                            if (bankContainer) {
                                const bankInputs = bankContainer.querySelectorAll(".input-group");
                                const newBankInput = document.createElement("div");
                                newBankInput.className = "input-group mb-2";
                                newBankInput.innerHTML = `
                                    <select class="form-control additional-bank" name="additional_bank_id[]">
                                        <option value="">Select Bank</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-success btn-add-lookup" data-table="bank">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger btn-remove-bank">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                `;
                                bankContainer.appendChild(newBankInput);
                                
                                // Initialize Select2 for the new dropdown
                                $('.additional-bank').select2({
                                    width: '100%',
                                    placeholder: 'Select an option',
                                    allowClear: true
                                });
                                
                                // Load bank data for the new dropdown
                                const select = newBankInput.querySelector('select');
                                $.ajax({
                                    url: '../../../models/entry/customer/fetch.php',
                                    type: 'GET',
                                    data: { table: 'bank' },
                                    dataType: 'json',
                                    success: function(response) {
                                        if (response.success && response.data) {
                                            response.data.forEach(item => {
                                                select.append(new Option(item.name, item.id));
                                            });
                                            $(select).trigger('change');
                                        }
                                    }
                                });
                            }
                        } else {
                            showAlert('warning', 'Maximum Reached', 'Maximum 5 IBAN numbers allowed.');
                        }
                    }

                    if (e.target.closest(".btn-remove-iban")) {
                        const inputs = container.querySelectorAll(".input-group");
                        if (inputs.length > 1) {
                            const index = Array.from(inputs).indexOf(e.target.closest(".input-group"));
                            e.target.closest(".input-group").remove();
                            
                            // Remove corresponding Bank dropdown
                            if (bankContainer) {
                                const bankInputs = bankContainer.querySelectorAll(".input-group");
                                if (bankInputs.length > 1 && index < bankInputs.length) {
                                    bankInputs[index].remove();
                                }
                            }
                        } else {
                            // Don't remove the last IBAN input, just clear it
                            inputs[0].querySelector("input").value = "";
                        }
                    }
                });
            }
            
            // Handle bank removal independently
            if (bankContainer) {
                bankContainer.addEventListener("click", function(e) {
                    if (e.target.closest(".btn-remove-bank")) {
                        const bankInputs = bankContainer.querySelectorAll(".input-group");
                        if (bankInputs.length > 1) {
                            const index = Array.from(bankInputs).indexOf(e.target.closest(".input-group"));
                            e.target.closest(".input-group").remove();
                            
                            // Remove corresponding IBAN input
                            if (container) {
                                const ibanInputs = container.querySelectorAll(".input-group");
                                if (ibanInputs.length > 1 && index < ibanInputs.length) {
                                    ibanInputs[index].remove();
                                }
                            }
                        } else {
                            // Don't remove the last bank input, just reset it
                            $(bankInputs[0].querySelector("select")).val('').trigger('change');
                        }
                    }
                });
            }
        }
        
        // Initialize DOB to Zodiac conversion
        function initializeDOBZodiacConversion() {
            $('#dob').on('change', function() {
                const dob = new Date($(this).val());
                const zodiacSign = getZodiacSign(dob);
                $('#star').val(zodiacSign).trigger('change');
            });
        }
        
        // Format zodiac option for select2
        function formatZodiacOption(option) {
            if (!option.id) return option.text;

            // Zodiac Unicode symbols
            const zodiacSymbols = {
                "Aries": "♈",
                "Taurus": "♉",
                "Gemini": "♊",
                "Cancer": "♋",
                "Leo": "♌",
                "Virgo": "♍",
                "Libra": "♎",
                "Scorpio": "♏",
                "Sagittarius": "♐",
                "Capricorn": "♑",
                "Aquarius": "♒",
                "Pisces": "♓"
            };

            // Extract the zodiac name from option.text
            const zodiacName = option.text.split(" ")[0];
            const symbol = zodiacSymbols[zodiacName] || "";

            const $icon = $('<span>')
                .text(symbol)
                .css({ 'margin-right': '10px', 'font-size': '18px' });

            const $text = $('<span>').text(option.text);

            return $('<span>').append($icon).append($text);
        }

        // Get zodiac sign from date
        function getZodiacSign(date) {
            const month = date.getMonth() + 1; // Months are 0-indexed in JavaScript
            const day = date.getDate();

            if ((month === 3 && day >= 21) || (month === 4 && day <= 19)) return 'Aries';
            if ((month === 4 && day >= 20) || (month === 5 && day <= 20)) return 'Taurus';
            if ((month === 5 && day >= 21) || (month === 6 && day <= 20)) return 'Gemini';
            if ((month === 6 && day >= 21) || (month === 7 && day <= 22)) return 'Cancer';
            if ((month === 7 && day >= 23) || (month === 8 && day <= 22)) return 'Leo';
            if ((month === 8 && day >= 23) || (month === 9 && day <= 22)) return 'Virgo';
            if ((month === 9 && day >= 23) || (month === 10 && day <= 22)) return 'Libra';
            if ((month === 10 && day >= 23) || (month === 11 && day <= 21)) return 'Scorpio';
            if ((month === 11 && day >= 22) || (month === 12 && day <= 21)) return 'Sagittarius';
            if ((month === 12 && day >= 22) || (month === 1 && day <= 19)) return 'Capricorn';
            if ((month === 1 && day >= 20) || (month === 2 && day <= 18)) return 'Aquarius';
            if ((month === 2 && day >= 19) || (month === 3 && day <= 20)) return 'Pisces';
            return ''; // Default value if no zodiac sign is found
        }

        // Function to load lookup data
        function loadLookupData(table) {
            debug('Loading data for table:', table);
            $.ajax({
                url: '../../../models/entry/customer/fetch.php',
                type: 'GET',
                data: { table: table },
                dataType: 'json',
                success: function(response) {
                    debug('Response:', response);
                    if (response.success && response.data) {
                        const select = table === 'bank' ? 
                            $(`#bank_id`) : 
                            $(`#${table}_id`);
                        
                        select.empty().append('<option value="">Select an option</option>');
                        response.data.forEach(item => {
                            select.append(new Option(item.name, item.id));
                        });
                        select.trigger('change');
                    } else {
                        showAlert('error', 'Error', `Failed to load ${table} data: ${response.error || 'Unknown error'}`);
                    }
                },
                error: function(xhr) {
                    showAlert('error', 'Error', `Error loading ${table} data: ${xhr.responseText || 'Network error'}`);
                }
            });
        }

        // Setup all event handlers
        function setupEventHandlers() {
            // Setup lookup buttons
            setupLookupButtons();
            
            // Setup image handlers
            setupImageHandlers();
            
            // Setup form submission
            setupFormSubmission();
            
            // Setup validation
            setupValidation();
            
            // Setup dependent dropdowns
            setupDependentDropdowns();
        }
        
        // Setup dependent dropdowns (country -> city -> area)
        function setupDependentDropdowns() {
            // When country changes, update city dropdown
            $('#countries_id').on('change', function() {
                const countryId = $(this).val();
                
                // Clear city dropdown
                $('#cities_id').empty().append('<option value="">Select City</option>').trigger('change');
                
                // Also clear area dropdown since city changed
                $('#areas_id').empty().append('<option value="">Select Area</option>').trigger('change');
                
                // If no country selected, disable city dropdown
                if (!countryId) {
                    $('#cities_id').prop('disabled', true).trigger('change');
                    $('#areas_id').prop('disabled', true).trigger('change');
                    return;
                }
                
                // Enable city dropdown and load cities for selected country
                $('#cities_id').prop('disabled', false);
                loadCitiesByCountry(countryId);
            });
            
            // When city changes, update area dropdown
            $('#cities_id').on('change', function() {
                const cityId = $(this).val();
                
                // Clear area dropdown
                $('#areas_id').empty().append('<option value="">Select Area</option>').trigger('change');
                
                // If no city selected, disable area dropdown
                if (!cityId) {
                    $('#areas_id').prop('disabled', true).trigger('change');
                    return;
                }
                
                // Enable area dropdown and load areas for selected city
                $('#areas_id').prop('disabled', false);
                loadAreasByCity(cityId);
            });
            
            // Initially disable city and area dropdowns until country is selected
            $('#cities_id').prop('disabled', true).trigger('change');
            $('#areas_id').prop('disabled', true).trigger('change');
        }

        // Load cities based on selected country
        function loadCitiesByCountry(countryId) {
            $.ajax({
                url: '../../../models/entry/customer/fetch.php',
                type: 'GET',
                data: { 
                    table: 'cities',
                    country_id: countryId 
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success && response.data) {
                        const citySelect = $('#cities_id');
                        citySelect.empty().append('<option value="">Select City</option>');
                        
                        response.data.forEach(city => {
                            citySelect.append(new Option(city.name, city.id));
                        });
                        
                        citySelect.trigger('change');
                    } else {
                        showAlert('error', 'Error', `Failed to load cities: ${response.error || 'Unknown error'}`);
                    }
                },
                error: function(xhr) {
                    showAlert('error', 'Error', `Error loading cities: ${xhr.responseText || 'Network error'}`);
                }
            });
        }
        
        // Load areas based on selected city
        function loadAreasByCity(cityId) {
            $.ajax({
                url: '../../../models/entry/customer/fetch.php',
                type: 'GET',
                data: { 
                    table: 'areas',
                    city_id: cityId 
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success && response.data) {
                        const areaSelect = $('#areas_id');
                        areaSelect.empty().append('<option value="">Select Area</option>');
                        
                        response.data.forEach(area => {
                            areaSelect.append(new Option(area.name, area.id));
                        });
                        
                        areaSelect.trigger('change');
                    } else {
                        showAlert('error', 'Error', `Failed to load areas: ${response.error || 'Unknown error'}`);
                    }
                },
                error: function(xhr) {
                    showAlert('error', 'Error', `Error loading areas: ${xhr.responseText || 'Network error'}`);
                }
            });
        }

        // Setup lookup buttons (add/delete)
        function setupLookupButtons() {
            // Handle lookup addition
            $('.btn-add-lookup').on('click', function() {
                const table = $(this).data('table');
                debug('Add button clicked for table:', table);

                Swal.fire({
                    title: 'Add New Item',
                    input: 'text',
                    inputLabel: `Enter new ${table.slice(0, -1)} name`,
                    inputPlaceholder: 'Type here...',
                    showCancelButton: true,
                    confirmButtonText: 'Add',
                    showLoaderOnConfirm: true,
                    preConfirm: (value) => {
                        if (!value) {
                            Swal.showValidationMessage('Please enter a name');
                            return false;
                        }
                        return $.ajax({
                            url: '../../../models/entry/customer/add.php',
                            type: 'POST',
                            data: {
                                table: table,
                                name: value
                            },
                            dataType: 'json'
                        }).then(response => {
                            if (!response.success) {
                                throw new Error(response.error || 'Failed to add item');
                            }
                            return response;
                        }).catch(error => {
                            Swal.showValidationMessage(`Request failed: ${error.message}`);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    if (result.isConfirmed) {
                        const select = $(`#${table}_id`);
                        const newOption = new Option(result.value.name, result.value.id, true, true);
                        select.append(newOption).trigger('change');
                        showAlert('success', 'Success', 'Item added successfully!');
                    }
                });
            });

            // Handle lookup deletion
            $('.btn-delete-lookup').on('click', function() {
                const table = $(this).data('table');
                const select = $(`#${table}_id`);
                const selectedId = select.val();
                const selectedText = select.find('option:selected').text();

                if (!selectedId) {
                    showAlert('warning', 'Warning', 'Please select an item to delete');
                    return;
                }

                Swal.fire({
                    title: 'Delete Item',
                    text: `Are you sure you want to delete "${selectedText}"?`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Yes, delete it!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return $.ajax({
                            url: '../../../models/entry/customer/delete.php',
                            type: 'POST',
                            data: {
                                _method: 'DELETE',
                                table: table,
                                id: selectedId
                            },
                            dataType: 'json'
                        }).then(response => {
                            if (!response.success) {
                                throw new Error(response.error || 'Failed to delete item');
                            }
                            return response;
                        }).catch(error => {
                            // Extract the error message from the response
                            const errorMessage = error.responseJSON?.error || error.message || 'Request failed: undefined';
                            throw new Error(errorMessage);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    if (result.isConfirmed) {
                        select.find(`option[value="${selectedId}"]`).remove();
                        select.val('').trigger('change');
                        showAlert('success', 'Success', 'Item deleted successfully!');
                    }
                }).catch(error => {
                    showAlert('error', 'Error', error.message);
                });
            });
        }
        
        // Setup image handlers
        function setupImageHandlers() {
            // Handle image files
            setupImageHandler('photo', 'preview-image', 'delete-picture', 'camera-photo');
            setupImageHandler('cnic_front', 'cnic-front-preview', 'delete-cnic-front', 'camera-cnic-front');
            setupImageHandler('cnic_back', 'cnic-back-preview', 'delete-cnic-back', 'camera-cnic-back');
            setupImageHandler('visiting_card', 'visiting-card-preview-image', 'delete-visiting-card', 'camera-visiting-card');
        }
        
        // Setup a single image handler (reusable)
        function setupImageHandler(inputId, previewId, deleteButtonId, cameraButtonId) {
            // Handle file selection
            $(`#${inputId}`).on('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    // Check if file is an image
                    if (!file.type.startsWith('image/')) {
                        showAlert('error', 'Invalid File Type', 'Please select an image file (JPG, PNG, etc.)');
                        $(this).val('');
                        return;
                    }

                    // Check file size (max 5MB)
                    const maxSize = 5 * 1024 * 1024; // 5MB in bytes
                    if (file.size > maxSize) {
                        showAlert('error', 'File Too Large', 'Please select an image less than 5MB');
                        $(this).val('');
                        return;
                    }

                    // Create preview and convert to WebP if possible
                    convertImageToWebP(file, function(webpBlob) {
                        if (webpBlob) {
                            // Use the WebP version for preview
                            const reader = new FileReader();
                            reader.onload = function(event) {
                                $(`#${previewId}`).attr('src', event.target.result);
                                $(`#${previewId}`).siblings('.picture-overlay').hide();
                            };
                            reader.readAsDataURL(webpBlob);
                            
                            showAlert('success', 'Success', 'Image converted to WebP for better performance!');
                        } else {
                            // If WebP conversion fails, use original file
                            const reader = new FileReader();
                            reader.onload = function(event) {
                                $(`#${previewId}`).attr('src', event.target.result);
                                $(`#${previewId}`).siblings('.picture-overlay').hide();
                            };
                            reader.readAsDataURL(file);
                            
                            showAlert('success', 'Success', 'Image uploaded successfully!');
                        }
                    });
                }
            });

            // Handle delete button
            $(`#${deleteButtonId}`).on('click', function() {
                Swal.fire({
                    title: 'Delete Image',
                    text: 'Are you sure you want to remove this image?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Reset file input
                        $(`#${inputId}`).val('');
                        // Reset preview image
                        $(`#${previewId}`).attr('src', '../../../assets/images/placeholder.png');
                        // Show overlay text
                        $(`#${previewId}`).siblings('.picture-overlay').show();

                        showAlert('success', 'Success', 'Image removed successfully!');
                    }
                });
            });
            
            // Handle camera button if it exists
            if (cameraButtonId) {
                $(`#${cameraButtonId}`).on('click', function() {
                    // Check if the device supports camera capture
                    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
                        showAlert('error', 'Not Supported', 'Camera capture is not supported on this device or browser');
                        return;
                    }
                    
                    // Create a modal with camera stream
                    Swal.fire({
                        title: 'Take a Picture',
                        html: `
                            <div style="position: relative; width: 100%; max-width: 500px; margin: 0 auto;">
                                <video id="camera-stream" style="width: 100%; max-height: 50vh; background: #000;" autoplay></video>
                                <button id="capture-btn" class="btn btn-primary btn-lg" style="position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%); z-index: 10;">
                                    <i class="fas fa-camera"></i> Capture
                                </button>
                                <canvas id="canvas-capture" style="display: none;"></canvas>
                            </div>
                        `,
                        showCancelButton: true,
                        showConfirmButton: false,
                        cancelButtonText: 'Cancel',
                        allowOutsideClick: false,
                        width: '80%',
                        willOpen: () => {
                            // Access camera when modal opens
                            const video = document.getElementById('camera-stream');
                            const constraints = {
                                video: {
                                    width: { ideal: 1280 },
                                    height: { ideal: 720 },
                                    facingMode: 'user'
                                }
                            };
                            
                            navigator.mediaDevices.getUserMedia(constraints)
                                .then(stream => {
                                    video.srcObject = stream;
                                })
                                .catch(err => {
                                    Swal.close();
                                    showAlert('error', 'Camera Error', 'Could not access the camera: ' + err.message);
                                });
                                
                            // Setup capture button
                            document.getElementById('capture-btn').addEventListener('click', function() {
                                const canvas = document.getElementById('canvas-capture');
                                const context = canvas.getContext('2d');
                                canvas.width = video.videoWidth;
                                canvas.height = video.videoHeight;
                                context.drawImage(video, 0, 0, canvas.width, canvas.height);
                                
                                // Convert to Blob/File
                                canvas.toBlob(function(blob) {
                                    const capturedFile = new File([blob], `captured_${Date.now()}.jpg`, { type: 'image/jpeg' });
                                    
                                    // Stop all video tracks
                                    const stream = video.srcObject;
                                    if (stream) {
                                        const tracks = stream.getTracks();
                                        tracks.forEach(track => track.stop());
                                    }
                                    
                                    // Close modal
                                    Swal.close();
                                    
                                    // Create input file event to trigger the normal flow
                                    const dataTransfer = new DataTransfer();
                                    dataTransfer.items.add(capturedFile);
                                    const fileInput = document.getElementById(inputId);
                                    fileInput.files = dataTransfer.files;
                                    
                                    // Trigger change event
                                    const event = new Event('change', { bubbles: true });
                                    fileInput.dispatchEvent(event);
                                }, 'image/jpeg', 0.9);
                            });
                        },
                        willClose: () => {
                            // Stop video stream when modal closes
                            const video = document.getElementById('camera-stream');
                            if (video.srcObject) {
                                const tracks = video.srcObject.getTracks();
                                tracks.forEach(track => track.stop());
                            }
                        }
                    });
                });
            }
        }
        
        /**
         * Convert image to WebP format for preview using canvas
         * @param {File} file - The original file object
         * @param {Function} callback - Callback function that receives the WebP blob
         */
        function convertImageToWebP(file, callback) {
            // Skip conversion for SVG files
            if (file.type === 'image/svg+xml') {
                callback(null); // Can't convert SVG to WebP in browser
                return;
            }
            
            const reader = new FileReader();
            reader.onload = function(event) {
                const img = new Image();
                img.onload = function() {
                    // Create a canvas element
                    const canvas = document.createElement('canvas');
                    canvas.width = img.width;
                    canvas.height = img.height;
                    
                    // Draw the image on the canvas
                    const ctx = canvas.getContext('2d');
                    ctx.drawImage(img, 0, 0);
                    
                    // Convert to WebP if supported
                    if (canvas.toBlob) {
                        canvas.toBlob(function(blob) {
                            if (blob) {
                                // Create a new File object from the blob
                                const webpFile = new File([blob], file.name.replace(/\.[^/.]+$/, '.webp'), {
                                    type: 'image/webp',
                                    lastModified: new Date().getTime()
                                });
                                callback(webpFile);
                            } else {
                                callback(null);
                            }
                        }, 'image/webp', 0.8);
                    } else {
                        // Fallback if toBlob is not supported
                        callback(null);
                    }
                };
                img.onerror = function() {
                    callback(null);
                };
                img.src = event.target.result;
            };
            reader.onerror = function() {
                callback(null);
            };
            reader.readAsDataURL(file);
        }
        
        // Setup form submission
        function setupFormSubmission() {
            $('#customerForm').on('submit', function(e) {
                e.preventDefault();

                // Basic validation
                let isValid = true;
                $(this).find('input[required]').each(function() {
                    if (!$(this).val()) {
                        isValid = false;
                        $(this).addClass('is-invalid');
                    } else {
                        $(this).removeClass('is-invalid');
                    }
                });

                if (!isValid) {
                    showAlert('error', 'Error', 'Please fill all required fields.');
                    return;
                }

                const formData = new FormData(this);

                // Add all additional cells as one combined string
                let additionalCells = [];
                $('#cell-numbers-container .input-group:not(:first-child) input').each(function() {
                    if ($(this).val()) {
                        additionalCells.push($(this).val());
                    }
                });
                
                // Process additional IBAN numbers
                let additionalIBANs = [];
                $('#iban-container .input-group:not(:first-child) input').each(function() {
                    if ($(this).val()) {
                        additionalIBANs.push($(this).val());
                    }
                });

                // Add additional cells as a note instead if there are any
                if (additionalCells.length > 0) {
                    let currentRemarks = $('#remarks').val();
                    let cellInfo = "Additional cell numbers: " + additionalCells.join(", ");

                    if (currentRemarks) {
                        $('#remarks').val(currentRemarks + "\n\n" + cellInfo);
                    } else {
                        $('#remarks').val(cellInfo);
                    }
                }
                
                // Add additional IBANs as a note if there are any
                if (additionalIBANs.length > 0) {
                    let currentRemarks = $('#remarks').val();
                    let ibanInfo = "Additional IBAN numbers: " + additionalIBANs.join(", ");

                    if (currentRemarks) {
                        $('#remarks').val(currentRemarks + "\n\n" + ibanInfo);
                    } else {
                        $('#remarks').val(ibanInfo);
                    }
                }

                // Submit form through controller bridge
                sendToController({
                    type: 'formSubmit',
                    formData: formData
                });
            });
        }
        
        // Save form data to localStorage
        function saveFormDataToCache() {
            if (!isFormModified()) return;
            
            const formData = {};
            
            // Save text inputs and textareas
            $('#customerForm input[type="text"], #customerForm input[type="tel"], #customerForm input[type="email"], #customerForm input[type="date"], #customerForm textarea').each(function() {
                const id = $(this).attr('id');
                if (id && $(this).val()) {
                    formData[id] = $(this).val();
                }
            });
            
            // Save select values
            $('#customerForm select').each(function() {
                const id = $(this).attr('id');
                if (id && $(this).val()) {
                    formData[id] = $(this).val();
                }
            });
            
            // Save additional cell numbers
            const additionalCells = [];
            $('#cell-numbers-container .input-group:not(:first-child) input').each(function() {
                if ($(this).val()) {
                    additionalCells.push($(this).val());
                }
            });
            if (additionalCells.length > 0) {
                formData['additional_cells'] = additionalCells;
            }
            
            // Store image previews as base64 (except if they're the default placeholder)
            ['preview-image', 'cnic-front-preview', 'cnic-back-preview', 'visiting-card-preview-image'].forEach(imgId => {
                const imgSrc = document.getElementById(imgId).src;
                if (imgSrc && !imgSrc.includes('placeholder.png')) {
                    formData[imgId] = imgSrc;
                }
            });
            
            // Save to localStorage with timestamp
            formData['timestamp'] = new Date().getTime();
            localStorage.setItem('customerFormData', JSON.stringify(formData));
            
            console.log('Form data cached at ' + new Date().toLocaleTimeString());
        }
        
        // Load cached form data from localStorage
        function loadCachedFormData() {
            const cachedData = localStorage.getItem('customerFormData');
            if (!cachedData) return;
            
            try {
                const formData = JSON.parse(cachedData);
                
                // Check if the cached data is too old (more than 1 day)
                const now = new Date().getTime();
                if (formData.timestamp && (now - formData.timestamp > 24 * 60 * 60 * 1000)) {
                    localStorage.removeItem('customerFormData');
                    return;
                }
                
                // Ask user if they want to restore the cached data
                Swal.fire({
                    title: 'Restore Data?',
                    text: 'Would you like to restore your previously unsaved form data?',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, restore it',
                    cancelButtonText: 'No, start fresh',
                    allowOutsideClick: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Restore text inputs and textareas
                        for (const id in formData) {
                            const element = document.getElementById(id);
                            if (element && (element.tagName === 'INPUT' || element.tagName === 'TEXTAREA')) {
                                $(element).val(formData[id]);
                            }
                        }
                        
                        // Restore select values with Select2
                        for (const id in formData) {
                            const element = document.getElementById(id);
                            if (element && element.tagName === 'SELECT') {
                                $(element).val(formData[id]).trigger('change');
                            }
                        }
                        
                        // Restore additional cell numbers
                        if (formData.additional_cells && formData.additional_cells.length > 0) {
                            formData.additional_cells.forEach(cell => {
                                const container = document.getElementById("cell-numbers-container");
                                const newInput = document.createElement("div");
                                newInput.className = "input-group mb-2";
                                newInput.innerHTML = `
                                    <input type="tel" class="form-control" name="additional_cell[]" value="${cell}" placeholder="Additional cell number">
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-success btn-add-cell">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger btn-remove-cell">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                `;
                                container.appendChild(newInput);
                            });
                        }
                        
                        // Restore image previews
                        ['preview-image', 'cnic-front-preview', 'cnic-back-preview', 'visiting-card-preview-image'].forEach(imgId => {
                            if (formData[imgId]) {
                                document.getElementById(imgId).src = formData[imgId];
                                // Hide overlay if applicable
                                const overlay = document.getElementById(imgId).closest('.picture-preview').querySelector('.picture-overlay');
                                if (overlay) overlay.style.display = 'none';
                            }
                        });
                        
                        showAlert('success', 'Data Restored', 'Your form data has been restored successfully');
                    } else {
                        // Clear the cached data if user chooses to start fresh
                        localStorage.removeItem('customerFormData');
                    }
                });
            } catch (error) {
                console.error('Error loading cached form data', error);
                localStorage.removeItem('customerFormData');
            }
        }
        
        // Clear form cache after successful submission
        function clearFormCache() {
            localStorage.removeItem('customerFormData');
        }
        
        // Reset form after successful submission
        function resetForm() {
            const saveButton = $('#saveButton');
            
            // Reset form for next entry (except the ID field)
            $('#customerForm').find('input:not(#id), select, textarea').val('');

            // Remove additional cell number fields
            $('#cell-numbers-container .input-group:not(:first-child)').remove();

            // Reset all select2 dropdowns
            $('select').val('').trigger('change');

            // Reset image previews
            $('#preview-image, #visiting-card-preview-image, #cnic-front-preview, #cnic-back-preview')
                .attr('src', '../../../assets/images/placeholder.png');

            // Show overlay texts
            $('.picture-overlay').show();

            // Switch back to first tab
            $('#personal-tab').tab('show');

            // Reset save button
            saveButton.prop('disabled', false).html('<i class="fas fa-save"></i> Save');
            
            // Clear the form cache
            clearFormCache();
        }
        
        // Handle form submission result
        function handleFormSubmitResult(response) {
            const saveButton = $('#saveButton');
            
            if (response && response.success) {
                showAlert('success', 'Success', 'Customer saved successfully!');
                
                // Request new customer ID
                fetchCustomerId();
                
                // Clear form cache after successful submission
                clearFormCache();
                
                // Reset form for next entry
                resetForm();
            } else {
                showAlert('error', 'Error', (response && response.error) ? response.error : 'Failed to save customer');
                saveButton.prop('disabled', false).html('<i class="fas fa-save"></i> Save');
            }
        }

        // Throttle function to limit how often a function can be called
        function throttle(func, limit) {
            let inThrottle;
            return function() {
                const args = arguments;
                const context = this;
                if (!inThrottle) {
                    func.apply(context, args);
                    inThrottle = true;
                    setTimeout(() => inThrottle = false, limit);
                }
            };
        }

        // Add styles dynamically for responsive container
        const style = document.createElement('style');
        style.textContent = `
            .container {
                width: 100%;
                padding-left: 15px;
                padding-right: 15px;
                margin-left: auto;
                margin-right: auto;
                transition: all 0.3s ease;
            }

            nav.expanded ~ .container {
                max-width: calc(100% - 250px);
                margin-left: 250px;
            }

            nav.collapsed ~ .container {
                max-width: calc(100% - 70px);
                margin-left: 70px;
            }
        `;
        document.head.appendChild(style);

        /* Sidebar transition listener */
        document.addEventListener('DOMContentLoaded', function() {
            // Listen for sidebar toggle events
            window.addEventListener('sidebar-toggle', function(e) {
                adjustContainerForSidebar();
            });
            
            // Initial adjustment
            adjustContainerForSidebar();
        });

        function adjustContainerForSidebar() {
            const nav = document.querySelector('nav');
            const containers = document.querySelectorAll('.container');
            
            containers.forEach(container => {
                if (nav.classList.contains('collapsed')) {
                    container.style.maxWidth = 'calc(100% - 70px)';
                    container.style.marginLeft = '70px';
                } else {
                    container.style.maxWidth = 'calc(100% - 250px)';
                    container.style.marginLeft = '250px';
                }
            });
        }