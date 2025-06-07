document.addEventListener('DOMContentLoaded', function() {
    // Initialize IndexedDB for offline operations
    initIndexedDB();
    
    // Check if we have valid cached data
    if (checkCachedData()) {
        // Use cached data to populate UI
        loadFromCache();
    } else {
        // No valid cache, fetch from server
        fetchCompanyData();
    }

    // Logo preview
    document.getElementById('company_logo').addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('logoPreview').innerHTML = 
                    `<img src="${e.target.result}" alt="Logo Preview">`;
            }
            reader.readAsDataURL(file);
        }
    });

    // Form submission
    document.getElementById('companySetupForm').addEventListener('submit', function(e) {
        e.preventDefault();
        submitForm();
    });
    
    // Setup online/offline event listeners
    window.addEventListener('online', handleOnlineStatus);
    window.addEventListener('offline', handleOnlineStatus);
    
    // Check initial connection status
    checkConnection();
    
    // Add refresh button functionality
    if (document.getElementById('refreshData')) {
        document.getElementById('refreshData').addEventListener('click', function() {
            refreshData();
        });
    } else {
        // Create refresh button if it doesn't exist
        const formContainer = document.querySelector('.form-container');
        const refreshButton = document.createElement('button');
        refreshButton.id = 'refreshData';
        refreshButton.className = 'refresh-button';
        refreshButton.innerHTML = '<i class="fas fa-sync"></i> Refresh Data';
        refreshButton.addEventListener('click', function() {
            refreshData();
        });
        formContainer.insertBefore(refreshButton, formContainer.firstChild);
    }
    
    // Add offline status indicator
    updateOfflineStatusIndicator();
});

// Variables to store data
let companyData = null;
let cacheExpiry = 5 * 60 * 1000; // Cache expiry time in milliseconds (5 minutes)
let isOnline = true; // Track online status
let offlineDb = null; // IndexedDB instance
let syncInterval = null; // Interval for connection attempts
const DB_NAME = 'companySetupOfflineDb';
const DB_VERSION = 1;
const PENDING_STORE = 'pendingOperations';
const COMPANY_STORE = 'companyData';

// Initialize IndexedDB
function initIndexedDB() {
    const request = indexedDB.open(DB_NAME, DB_VERSION);
    
    request.onerror = function(event) {
        console.error("IndexedDB error:", event.target.error);
    };
    
    request.onupgradeneeded = function(event) {
        const db = event.target.result;
        
        // Create object store for pending operations
        if (!db.objectStoreNames.contains(PENDING_STORE)) {
            const pendingStore = db.createObjectStore(PENDING_STORE, { keyPath: 'id', autoIncrement: true });
            pendingStore.createIndex('timestamp', 'timestamp', { unique: false });
        }
        
        // Create object store for company data
        if (!db.objectStoreNames.contains(COMPANY_STORE)) {
            const companyStore = db.createObjectStore(COMPANY_STORE, { keyPath: 'id' });
        }
    };
    
    request.onsuccess = function(event) {
        offlineDb = event.target.result;
        console.log("IndexedDB initialized successfully");
        
        // Check for pending operations on startup
        checkPendingOperations();
    };
}

// Function to fetch company data
function fetchCompanyData() {
    // Show loading indicator
    showLoading(true);
    
    fetch('../../../controllers/setup/companySetup/fetch_company_data.php')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Store data in variable
                companyData = data.company_data;
                
                // Save to cache
                saveToCache(data.company_data);
                
                // Populate form
                populateForm(data.company_data);
                
                // Store in IndexedDB
                storeCompanyDataInIndexedDB(data.company_data);
            } else if (data.error) {
                showError(data.error);
            }
            
            // Hide loading indicator
            showLoading(false);
        })
        .catch(error => {
            console.error('Error fetching company data:', error);
            
            // Try to load from IndexedDB if fetch fails
            loadFromIndexedDB().then(data => {
                if (data) {
                    populateForm(data);
                    showWarning('Using locally stored data. Some information may not be up to date.');
                }
            });
            
            // Hide loading indicator
            showLoading(false);
            
            // Update online status
            isOnline = false;
            updateOfflineStatusIndicator();
        });
}

// Helper function to show/hide loading indicator
function showLoading(show) {
    if (show) {
        // If loading indicator doesn't exist, create it
        if ($('#loadingIndicator').length === 0) {
            $('body').append('<div id="loadingIndicator" class="loading-overlay"><div class="loading-spinner"></div></div>');
        }
        $('#loadingIndicator').show();
    } else {
        $('#loadingIndicator').hide();
    }
}

// Function to store company data in IndexedDB
function storeCompanyDataInIndexedDB(data) {
    if (!offlineDb) return;
    
    const transaction = offlineDb.transaction([COMPANY_STORE], "readwrite");
    const store = transaction.objectStore(COMPANY_STORE);
    
    // Always store with ID 1 as we only have one company
    const companyData = {
        id: 1,
        data: data,
        timestamp: new Date().getTime()
    };
    
    store.put(companyData);
}

// Function to load company data from IndexedDB
function loadFromIndexedDB() {
    return new Promise((resolve, reject) => {
        if (!offlineDb) {
            reject("IndexedDB not initialized");
            return;
        }
        
        const transaction = offlineDb.transaction([COMPANY_STORE], "readonly");
        const store = transaction.objectStore(COMPANY_STORE);
        const request = store.get(1); // Always ID 1 for the company
        
        request.onsuccess = function(event) {
            if (event.target.result) {
                resolve(event.target.result.data);
            } else {
                resolve(null);
            }
        };
        
        request.onerror = function(event) {
            reject("Error loading from IndexedDB: " + event.target.error);
        };
    });
}

// Cache management functions
function checkCachedData() {
    // Get timestamp of cache
    const timestamp = localStorage.getItem('company_cache_timestamp');
    if (!timestamp) return false;
    
    // Check if cache has expired
    const now = new Date().getTime();
    if (now - parseInt(timestamp) > cacheExpiry) return false;
    
    // Check if company data exists in cache
    if (!localStorage.getItem('company_data')) {
        return false;
    }
    
    return true;
}

function loadFromCache() {
    try {
        // Load data from localStorage
        companyData = JSON.parse(localStorage.getItem('company_data') || 'null');
        
        if (companyData) {
            // Populate form
            populateForm(companyData);
            console.log('Company data loaded from cache');
            
            // Refresh cache in the background
            setTimeout(fetchCompanyData, 100);
        } else {
            fetchCompanyData();
        }
    } catch (e) {
        console.error('Error loading from cache:', e);
        // If any error occurs, fetch from server
        fetchCompanyData();
    }
}

function saveToCache(data) {
    try {
        // Save data to localStorage
        localStorage.setItem('company_data', JSON.stringify(data));
        localStorage.setItem('company_cache_timestamp', new Date().getTime().toString());
        
        console.log('Company data saved to cache');
    } catch (e) {
        console.error('Error saving to cache:', e);
        // If storage quota is exceeded, clear cache and try again
        if (e.name === 'QuotaExceededError') {
            clearCompanyCache();
            try {
                localStorage.setItem('company_data', JSON.stringify(data));
                localStorage.setItem('company_cache_timestamp', new Date().getTime().toString());
            } catch (retryError) {
                console.error('Failed to save to cache after clearing:', retryError);
            }
        }
    }
}

function clearCompanyCache() {
    localStorage.removeItem('company_data');
    localStorage.removeItem('company_cache_timestamp');
    console.log('Company cache cleared');
}

// Function to populate form with company data
function populateForm(data) {
    if (!data) return;
    
    // Populate text fields
    document.getElementById('company_name').value = data.company_name || '';
    document.getElementById('address_line1').value = data.address_line1 || '';
    document.getElementById('address_line2').value = data.address_line2 || '';
    document.getElementById('city').value = data.city || '';
    document.getElementById('state').value = data.state || '';
    document.getElementById('postal_code').value = data.postal_code || '';
    document.getElementById('country').value = data.country || '';
    document.getElementById('phone_1').value = data.phone_1 || '';
    document.getElementById('phone_2').value = data.phone_2 || '';
    document.getElementById('email').value = data.email || '';
    document.getElementById('website').value = data.website || '';
    document.getElementById('tax_id').value = data.tax_id || '';
    document.getElementById('registration_number').value = data.registration_number || '';
    
    // Display logo if available
    if (data.company_logo) {
        document.getElementById('logoPreview').innerHTML = 
            `<img src="${data.company_logo}" alt="Company Logo">`;
    }
}

// Handle online/offline status changes
function handleOnlineStatus() {
    const wasOnline = isOnline;
    isOnline = navigator.onLine;
    
    updateOfflineStatusIndicator();
    
    // If we just came back online
    if (!wasOnline && isOnline) {
        console.log("Connection restored - syncing data");
        syncPendingOperations();
    } else if (wasOnline && !isOnline) {
        console.log("Connection lost - entering offline mode");
        // Start polling for connection if not already started
        startConnectionPolling();
    }
}

// Check connection to server
function checkConnection() {
    fetch('../../../controllers/setup/companySetup/fetch_company_data.php', {
        method: 'HEAD',
        cache: 'no-store',
        headers: {
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache'
        },
        timeout: 2000
    })
    .then(() => {
        isOnline = true;
        updateOfflineStatusIndicator();
        
        // If we were offline but now online, sync data
        if (syncInterval !== null) {
            syncPendingOperations();
        }
    })
    .catch(() => {
        isOnline = false;
        updateOfflineStatusIndicator();
        
        // Start polling for connection if not already started
        startConnectionPolling();
    });
}

// Start polling for connection recovery
function startConnectionPolling() {
    if (syncInterval === null) {
        console.log("Starting connection polling");
        syncInterval = setInterval(function() {
            checkConnection();
        }, 5000); // Check every 5 seconds
    }
}

// Stop polling for connection
function stopConnectionPolling() {
    if (syncInterval !== null) {
        console.log("Stopping connection polling");
        clearInterval(syncInterval);
        syncInterval = null;
    }
}

// Update offline status indicator
function updateOfflineStatusIndicator() {
    if (isOnline) {
        $('#offlineIndicator').remove();
        stopConnectionPolling();
    } else {
        if ($('#offlineIndicator').length === 0) {
            $('body').append('<div id="offlineIndicator" class="offline-indicator">You are offline. Changes will be saved when connection is restored.</div>');
        }
    }
}

// Function to submit the form via AJAX or store for offline sync
function submitForm() {
    const form = document.getElementById('companySetupForm');
    const formData = new FormData(form);
    
    // Show loading state
    const submitButton = document.getElementById('submitButton');
    const originalButtonText = submitButton.innerHTML;
    submitButton.innerHTML = 'Saving...';
    submitButton.disabled = true;
    
    if (isOnline) {
        // Online submission
        fetch('../../../controllers/setup/companySetup/index.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            // Reset button state
            submitButton.innerHTML = originalButtonText;
            submitButton.disabled = false;
            
            if (data.success) {
                showSuccess(data.message);
                // Refresh company data
                fetchCompanyData();
            } else if (data.error) {
                showError(data.message);
            }
        })
        .catch(error => {
            // Reset button state
            submitButton.innerHTML = originalButtonText;
            submitButton.disabled = false;
            
            // Connection may have been lost during submission
            isOnline = false;
            updateOfflineStatusIndicator();
            
            // Store for offline submission
            storeForOfflineSubmission(formDataToObject(formData))
                .then(() => {
                    showWarning('You are offline. Your changes will be saved when connection is restored.');
                })
                .catch(error => {
                    showError('Error storing offline changes: ' + error);
                });
        });
    } else {
        // Offline submission - store for later
        storeForOfflineSubmission(formDataToObject(formData))
            .then(() => {
                // Reset button state
                submitButton.innerHTML = originalButtonText;
                submitButton.disabled = false;
                
                showWarning('You are offline. Your changes will be saved when connection is restored.');
                
                // Update local data optimistically
                updateLocalDataOptimistically(formDataToObject(formData));
            })
            .catch(error => {
                // Reset button state
                submitButton.innerHTML = originalButtonText;
                submitButton.disabled = false;
                
                showError('Error storing offline changes: ' + error);
            });
    }
}

// Helper function to convert FormData to object
function formDataToObject(formData) {
    const obj = {};
    for (let [key, value] of formData.entries()) {
        // Handle file fields differently
        if (value instanceof File) {
            if (value.size > 0) {
                obj[key] = {
                    type: 'file',
                    name: value.name,
                    lastModified: value.lastModified
                };
                
                // We won't store the actual file in IndexedDB for now
                // as it's complex to handle file uploads offline
                // Instead we'll flag that a file was selected and prompt
                // the user to resubmit when back online
            }
        } else {
            obj[key] = value;
        }
    }
    return obj;
}

// Store form data for offline submission
function storeForOfflineSubmission(data) {
    return new Promise((resolve, reject) => {
        if (!offlineDb) {
            reject("IndexedDB not initialized");
            return;
        }
        
        const transaction = offlineDb.transaction([PENDING_STORE], "readwrite");
        const store = transaction.objectStore(PENDING_STORE);
        
        // Add timestamp
        const operation = {
            operationType: 'update_company',
            data: data,
            timestamp: new Date().getTime()
        };
        
        const request = store.add(operation);
        
        request.onsuccess = function() {
            resolve(request.result);
        };
        
        request.onerror = function(event) {
            reject("Error storing offline operation: " + event.target.error);
        };
    });
}

// Update local data optimistically
function updateLocalDataOptimistically(formData) {
    // Update in-memory data
    if (companyData) {
        for (let key in formData) {
            if (typeof formData[key] === 'object' && formData[key].type === 'file') {
                // Skip file objects
                continue;
            }
            companyData[key] = formData[key];
        }
    } else {
        companyData = formData;
    }
    
    // Update cache
    saveToCache(companyData);
    
    // Update IndexedDB
    storeCompanyDataInIndexedDB(companyData);
}

// Check for pending operations on startup
function checkPendingOperations() {
    if (!offlineDb) return;
    
    const transaction = offlineDb.transaction([PENDING_STORE], "readonly");
    const store = transaction.objectStore(PENDING_STORE);
    const countRequest = store.count();
    
    countRequest.onsuccess = function() {
        const count = countRequest.result;
        if (count > 0) {
            console.log(`Found ${count} pending operations`);
            // Show notification to user
            showPendingOperationsNotification(count);
            // Start connection polling to try syncing
            startConnectionPolling();
        }
    };
}

// Show notification about pending operations
function showPendingOperationsNotification(count) {
    $('body').append(`
        <div id="pendingOpsNotification" class="notification">
            You have ${count} unsaved changes. 
            <button id="syncNowBtn" class="sync-now-btn">Sync Now</button>
            <span class="notification-close" onclick="$('#pendingOpsNotification').remove();">&times;</span>
        </div>
    `);
    
    $('#syncNowBtn').on('click', function() {
        $('#pendingOpsNotification').remove();
        syncPendingOperations();
    });
}

// Sync pending operations when back online
function syncPendingOperations() {
    return new Promise((resolve, reject) => {
        if (!offlineDb) {
            reject("IndexedDB not initialized");
            return;
        }
        
        console.log("Syncing pending operations...");
        
        const transaction = offlineDb.transaction([PENDING_STORE], "readonly");
        const store = transaction.objectStore(PENDING_STORE);
        const index = store.index('timestamp');
        const request = index.openCursor();
        const operations = [];
        
        request.onsuccess = function(event) {
            const cursor = event.target.result;
            if (cursor) {
                operations.push(cursor.value);
                cursor.continue();
            } else {
                // Check if we have any file operations that need special handling
                const hasFileUploads = operations.some(op => {
                    for (let key in op.data) {
                        if (typeof op.data[key] === 'object' && op.data[key].type === 'file') {
                            return true;
                        }
                    }
                    return false;
                });
                
                if (hasFileUploads) {
                    // We have file uploads, which can't be processed automatically
                    showFileUploadWarning();
                    clearAllPendingOperations();
                    resolve();
                    return;
                }
                
                // Process operations sequentially
                processOperationsSequentially(operations)
                    .then(() => {
                        console.log("All pending operations processed");
                        stopConnectionPolling();
                        fetchCompanyData(); // Refresh data
                        resolve();
                    })
                    .catch(error => {
                        console.error("Error processing operations:", error);
                        reject(error);
                    });
            }
        };
        
        request.onerror = function(event) {
            reject("Error retrieving pending operations: " + event.target.error);
        };
    });
}

// Show warning about file uploads
function showFileUploadWarning() {
    showWarning('Some changes included file uploads which cannot be processed automatically. Please submit your form again when online.');
}

// Clear all pending operations
function clearAllPendingOperations() {
    if (!offlineDb) return;
    
    const transaction = offlineDb.transaction([PENDING_STORE], "readwrite");
    const store = transaction.objectStore(PENDING_STORE);
    store.clear();
}

// Process operations one by one
function processOperationsSequentially(operations) {
    return operations.reduce((promise, operation) => {
        return promise.then(() => {
            return processOperation(operation);
        });
    }, Promise.resolve());
}

// Process a single operation
function processOperation(operation) {
    return new Promise((resolve, reject) => {
        console.log("Processing operation:", operation);
        
        if (operation.operationType === 'update_company') {
            // Convert to FormData for submission
            const formData = new FormData();
            
            for (let key in operation.data) {
                if (typeof operation.data[key] === 'object' && operation.data[key].type === 'file') {
                    // Skip file fields
                    continue;
                }
                formData.append(key, operation.data[key]);
            }
            
            fetch('../../../controllers/setup/companySetup/index.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Operation successful, remove from pending
                    removeOperation(operation.id)
                        .then(() => resolve())
                        .catch(error => reject(error));
                } else {
                    // Operation failed
                    console.error("Operation failed:", data.error);
                    removeOperation(operation.id)
                        .then(() => resolve())
                        .catch(error => reject(error));
                }
            })
            .catch(error => {
                // Still having connection issues
                reject("Failed to process operation: " + error);
            });
        } else {
            // Unknown operation type
            removeOperation(operation.id)
                .then(() => resolve())
                .catch(error => reject(error));
        }
    });
}

// Remove processed operation
function removeOperation(id) {
    return new Promise((resolve, reject) => {
        const transaction = offlineDb.transaction([PENDING_STORE], "readwrite");
        const store = transaction.objectStore(PENDING_STORE);
        const request = store.delete(id);
        
        request.onsuccess = function() {
            resolve();
        };
        
        request.onerror = function(event) {
            reject("Error removing operation: " + event.target.error);
        };
    });
}

// Refresh data
function refreshData() {
    fetchCompanyData();
}

// Function to show success message
function showSuccess(message) {
    const successElement = document.getElementById('success-message');
    successElement.textContent = message;
    successElement.style.display = 'block';
    
    // Hide error and warning messages if shown
    document.getElementById('error-message').style.display = 'none';
    document.getElementById('warning-message')?.style.display = 'none';
    
    // Hide success message after 5 seconds
    setTimeout(() => {
        successElement.style.display = 'none';
    }, 5000);
}

// Function to show error message
function showError(message) {
    const errorElement = document.getElementById('error-message');
    errorElement.textContent = message;
    errorElement.style.display = 'block';
    
    // Hide success and warning messages if shown
    document.getElementById('success-message').style.display = 'none';
    document.getElementById('warning-message')?.style.display = 'none';
}

// Helper function to show warning message
function showWarning(message) {
    // Create warning element if it doesn't exist
    let warningElement = document.getElementById('warning-message');
    if (!warningElement) {
        warningElement = document.createElement('div');
        warningElement.id = 'warning-message';
        warningElement.className = 'message warning';
        const messagesContainer = document.querySelector('.messages');
        if (messagesContainer) {
            messagesContainer.appendChild(warningElement);
        } else {
            // If messages container doesn't exist, create one
            const container = document.createElement('div');
            container.className = 'messages';
            container.appendChild(warningElement);
            document.querySelector('.setup-form').prepend(container);
        }
    }
    
    warningElement.textContent = message;
    warningElement.style.display = 'block';
    
    // Hide success and error messages if shown
    const successElement = document.getElementById('success-message');
    const errorElement = document.getElementById('error-message');
    
    if (successElement) successElement.style.display = 'none';
    if (errorElement) errorElement.style.display = 'none';
    
    // Hide warning message after 5 seconds
    setTimeout(() => {
        warningElement.style.display = 'none';
    }, 5000);
}