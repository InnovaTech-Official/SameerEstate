// JavaScript for Chart of Accounts with offline support

// Variables to store data
let accountHeads = [];
let subAccounts = [];
let accounts = [];
let cacheExpiry = 5 * 60 * 1000; // Cache expiry time in milliseconds (5 minutes)
let isOnline = true; // Track online status
let offlineDb = null; // IndexedDB instance
let syncInterval = null; // Interval for connection attempts
const DB_NAME = 'coaOfflineDb';
const DB_VERSION = 1;
const PENDING_STORE = 'pendingOperations';
const CONFLICT_STORE = 'conflictOperations';

// Initialize on document ready
$(document).ready(function() {
    // Initialize IndexedDB for offline operations
    initIndexedDB();
    
    // Check if we have valid cached data
    if (checkCachedData()) {
        // Use cached data to populate UI
        loadFromCache();
    } else {
        // No valid cache, fetch from server
        fetchData();
    }
    
    // Initialize Select2 for dropdowns
    $('#account_head_id').select2();
    $('#sub_account_id').select2();
    
    // Setup online/offline event listeners
    window.addEventListener('online', handleOnlineStatus);
    window.addEventListener('offline', handleOnlineStatus);
    
    // Check initial connection status
    checkConnection();
    
    // Handle form submissions via AJAX
    setupFormHandlers();
    
    // Add refresh button functionality
    $('#refreshData').on('click', function() {
        refreshData();
    });
    
    // Add offline status indicator
    updateOfflineStatusIndicator();
});

// Fetch data from server
function fetchData(forceRefresh = false) {
    // Show loading indicator
    showLoading(true);
    
    $.ajax({
        url: 'index.php',
        type: 'GET',
        data: { 
            fetch_data: true,
            cache_buster: forceRefresh ? new Date().getTime() : undefined
        },
        dataType: 'json',
        success: function(response) {
            if (response.error) {
                alert('Error loading data: ' + response.error);
                showLoading(false);
                return;
            }
            
            // Store data in variables
            accountHeads = response.account_heads || [];
            subAccounts = response.sub_accounts || [];
            accounts = response.accounts || [];
            
            // Save to cache
            saveToCache(response);
            
            // Populate dropdowns and lists
            populateAccountHeadsDropdown();
            populateSubAccountsDropdown();
            populateAccountHeadsList();
            populateSubAccountsList();
            populateAccountsList();
            
            // Hide loading indicator
            showLoading(false);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('Error fetching data: ' + errorThrown);
            showLoading(false);
        }
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

// Cache management functions
function checkCachedData() {
    // Get timestamp of cache
    const timestamp = localStorage.getItem('coa_cache_timestamp');
    if (!timestamp) return false;
    
    // Check if cache has expired
    const now = new Date().getTime();
    if (now - parseInt(timestamp) > cacheExpiry) return false;
    
    // Check if all required cache items exist
    if (!localStorage.getItem('coa_account_heads') || 
        !localStorage.getItem('coa_sub_accounts') || 
        !localStorage.getItem('coa_accounts')) {
        return false;
    }
    
    return true;
}

function loadFromCache() {
    try {
        // Load data from localStorage
        accountHeads = JSON.parse(localStorage.getItem('coa_account_heads') || '[]');
        subAccounts = JSON.parse(localStorage.getItem('coa_sub_accounts') || '[]');
        accounts = JSON.parse(localStorage.getItem('coa_accounts') || '[]');
        
        // Populate UI
        populateAccountHeadsDropdown();
        populateSubAccountsDropdown();
        populateAccountHeadsList();
        populateSubAccountsList();
        populateAccountsList();
        
        console.log('Data loaded from cache');
        
        // Refresh cache in the background
        setTimeout(fetchData, 100);
    } catch (e) {
        console.error('Error loading from cache:', e);
        // If any error occurs, fetch from server
        fetchData();
    }
}

function saveToCache(data) {
    try {
        // Save data to localStorage
        localStorage.setItem('coa_account_heads', JSON.stringify(data.account_heads || []));
        localStorage.setItem('coa_sub_accounts', JSON.stringify(data.sub_accounts || []));
        localStorage.setItem('coa_accounts', JSON.stringify(data.accounts || []));
        localStorage.setItem('coa_cache_timestamp', new Date().getTime().toString());
        
        console.log('Data saved to cache');
    } catch (e) {
        console.error('Error saving to cache:', e);
        // If storage quota is exceeded, clear cache and try again
        if (e.name === 'QuotaExceededError') {
            clearCoaCache();
            try {
                localStorage.setItem('coa_account_heads', JSON.stringify(data.account_heads || []));
                localStorage.setItem('coa_sub_accounts', JSON.stringify(data.sub_accounts || []));
                localStorage.setItem('coa_accounts', JSON.stringify(data.accounts || []));
                localStorage.setItem('coa_cache_timestamp', new Date().getTime().toString());
            } catch (retryError) {
                console.error('Failed to save to cache after clearing:', retryError);
            }
        }
    }
}

function clearCoaCache() {
    localStorage.removeItem('coa_account_heads');
    localStorage.removeItem('coa_sub_accounts');
    localStorage.removeItem('coa_accounts');
    localStorage.removeItem('coa_cache_timestamp');
    console.log('COA cache cleared');
}

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
            pendingStore.createIndex('operationType', 'operationType', { unique: false });
        }
        
        // Create object store for conflict operations
        if (!db.objectStoreNames.contains(CONFLICT_STORE)) {
            const conflictStore = db.createObjectStore(CONFLICT_STORE, { keyPath: 'id', autoIncrement: true });
            conflictStore.createIndex('originalId', 'originalId', { unique: false });
            conflictStore.createIndex('timestamp', 'timestamp', { unique: false });
        }
    };
    
    request.onsuccess = function(event) {
        offlineDb = event.target.result;
        console.log("IndexedDB initialized successfully");
        
        // Check for pending operations on startup
        checkPendingOperations();
    };
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
    $.ajax({
        url: 'index.php',
        type: 'HEAD',
        timeout: 2000,
        success: function() {
            isOnline = true;
            updateOfflineStatusIndicator();
            
            // If we were offline but now online, sync data
            if (syncInterval !== null) {
                syncPendingOperations();
            }
        },
        error: function() {
            isOnline = false;
            updateOfflineStatusIndicator();
            
            // Start polling for connection if not already started
            startConnectionPolling();
        }
    });
}

// Start polling for connection recovery
function startConnectionPolling() {
    if (syncInterval === null) {
        console.log("Starting connection polling");
        syncInterval = setInterval(function() {
            checkConnection();
        }, 1000); // Check every second
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

// Store operation in IndexedDB for offline mode
function storeOfflineOperation(operationType, data) {
    return new Promise((resolve, reject) => {
        if (!offlineDb) {
            reject("IndexedDB not initialized");
            return;
        }
        
        const transaction = offlineDb.transaction([PENDING_STORE], "readwrite");
        const store = transaction.objectStore(PENDING_STORE);
        
        // Add timestamp and operationType
        const operation = {
            operationType: operationType,
            data: data,
            timestamp: new Date().getTime(),
            clientId: getClientId() // Generate unique client ID for conflict resolution
        };
        
        // Check for potential conflicts (same operation type on same entity ID)
        checkForConflicts(operationType, data).then(() => {
            const request = store.add(operation);
            
            request.onsuccess = function() {
                resolve(request.result);
            };
            
            request.onerror = function(event) {
                reject("Error storing offline operation: " + event.target.error);
            };
        }).catch(error => {
            reject(error);
        });
    });
}

// Check for potential conflicts in pending operations
function checkForConflicts(operationType, data) {
    return new Promise((resolve, reject) => {
        if (!offlineDb) {
            reject("IndexedDB not initialized");
            return;
        }
        
        // Only need to check for conflicts on edit/delete operations
        if (operationType === 'add_account_head' || 
            operationType === 'add_sub_account' || 
            operationType === 'add_account') {
            resolve(); // No conflict possible for new items
            return;
        }
        
        const transaction = offlineDb.transaction([PENDING_STORE], "readonly");
        const store = transaction.objectStore(PENDING_STORE);
        const request = store.openCursor();
        let conflicts = false;
        
        request.onsuccess = function(event) {
            const cursor = event.target.result;
            if (cursor) {
                const op = cursor.value;
                
                // Check for operations on the same entity
                if (op.operationType === 'edit_account' && operationType === 'edit_account' && 
                    op.data.edit_id === data.edit_id && op.data.edit_type === data.edit_type) {
                    conflicts = true;
                }
                
                // Check for operations on deleted entities
                if (op.operationType === 'delete_id' && 
                    (operationType === 'edit_account' || operationType === 'delete_id') &&
                    op.data.delete_id === data.edit_id && op.data.delete_type === data.edit_type) {
                    conflicts = true;
                }
                
                cursor.continue();
            } else {
                if (conflicts) {
                    reject("Conflict detected: Operation on same entity already pending");
                } else {
                    resolve();
                }
            }
        };
        
        request.onerror = function(event) {
            reject("Error checking for conflicts: " + event.target.error);
        };
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
                // Sort operations by timestamp
                operations.sort((a, b) => a.timestamp - b.timestamp);
                
                // Process operations sequentially
                processOperationsSequentially(operations)
                    .then(() => {
                        console.log("All pending operations processed");
                        stopConnectionPolling();
                        refreshData(true);
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
        
        $.ajax({
            url: 'index.php',
            type: 'POST',
            data: { ...operation.data, ajax: true },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Operation successful, remove from pending
                    removeOperation(operation.id)
                        .then(() => resolve())
                        .catch(error => reject(error));
                } else if (response.conflict) {
                    // Server detected a conflict, move to conflict store
                    moveToConflictStore(operation, response.conflictDetails)
                        .then(() => resolve())
                        .catch(error => reject(error));
                } else {
                    // Operation failed but not due to conflict
                    console.error("Operation failed:", response.error);
                    removeOperation(operation.id)
                        .then(() => resolve())
                        .catch(error => reject(error));
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // Still having connection issues
                reject("Failed to process operation: " + errorThrown);
            }
        });
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

// Move operation to conflict store
function moveToConflictStore(operation, conflictDetails) {
    return new Promise((resolve, reject) => {
        const transaction = offlineDb.transaction([PENDING_STORE, CONFLICT_STORE], "readwrite");
        const pendingStore = transaction.objectStore(PENDING_STORE);
        const conflictStore = transaction.objectStore(CONFLICT_STORE);
        
        // Add to conflict store
        const conflictOp = {
            originalId: operation.id,
            operation: operation,
            conflictDetails: conflictDetails,
            timestamp: new Date().getTime()
        };
        
        const addRequest = conflictStore.add(conflictOp);
        
        addRequest.onsuccess = function() {
            // Remove from pending store
            const deleteRequest = pendingStore.delete(operation.id);
            
            deleteRequest.onsuccess = function() {
                resolve();
            };
            
            deleteRequest.onerror = function(event) {
                reject("Error removing from pending store: " + event.target.error);
            };
        };
        
        addRequest.onerror = function(event) {
            reject("Error adding to conflict store: " + event.target.error);
        };
    });
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

// Generate client ID for conflict resolution
function getClientId() {
    // Get or create client ID
    let clientId = localStorage.getItem('coa_client_id');
    if (!clientId) {
        clientId = 'client_' + Math.random().toString(36).substr(2, 9);
        localStorage.setItem('coa_client_id', clientId);
    }
    return clientId;
}

// Setup form handlers for AJAX and offline support
function setupFormHandlers() {
    // Handle form submissions via AJAX
    $('form').on('submit', function(e) {
        // Skip AJAX for forms that need to do a full postback
        if ($(this).hasClass('no-ajax')) {
            return true;
        }
        
        e.preventDefault();
        
        // Show loading indicator
        showLoading(true);
        
        // Determine operation type from form
        const operationType = getOperationTypeFromForm($(this));
        const formData = $(this).serialize();
        const formDataObj = formToObject($(this));
        
        // If online, submit directly
        if (isOnline) {
            submitFormOnline($(this), operationType);
        } else {
            // Store operation for later sync
            storeOfflineOperation(operationType, formDataObj)
                .then(() => {
                    showLoading(false);
                    
                    // Show success message
                    alert("You're offline. This change will be synchronized when your connection is restored.");
                    
                    // Reset form
                    $(this)[0].reset();
                    
                    // Reset Select2
                    $(this).find('.select2-hidden-accessible').val(null).trigger('change');
                    
                    // Apply optimistic updates to UI
                    applyOptimisticUpdate(operationType, formDataObj);
                })
                .catch(error => {
                    showLoading(false);
                    alert("Error: " + error);
                });
        }
    });
}

// Get operation type from form
function getOperationTypeFromForm($form) {
    if ($form.find('[name="add_account_head"]').length) return 'add_account_head';
    if ($form.find('[name="add_sub_account"]').length) return 'add_sub_account';
    if ($form.find('[name="add_account"]').length) return 'add_account';
    if ($form.find('[name="edit_id"]').length) return 'edit_account';
    if ($form.find('[name="delete_id"]').length) return 'delete_id';
    return 'unknown';
}

// Convert form to object
function formToObject($form) {
    const formArray = $form.serializeArray();
    const obj = {};
    
    $.map(formArray, function(n, i) {
        obj[n['name']] = n['value'];
    });
    
    return obj;
}

// Submit form when online
function submitFormOnline($form, operationType) {
    $.ajax({
        url: $form.attr('action'),
        type: $form.attr('method'),
        data: $form.serialize() + '&ajax=true',
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                alert(response.message);
                refreshData(); // Refresh data and cache
                
                // Reset form
                $form[0].reset();
                
                // Reset Select2
                $form.find('.select2-hidden-accessible').val(null).trigger('change');
            } else {
                alert('Error: ' + response.error);
            }
            showLoading(false);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // If connection error occurred during submission
            if (textStatus === 'timeout' || textStatus === 'error' || jqXHR.status === 0) {
                isOnline = false;
                updateOfflineStatusIndicator();
                
                // Store operation for later sync
                const formDataObj = formToObject($form);
                storeOfflineOperation(operationType, formDataObj)
                    .then(() => {
                        alert("Connection lost. Your change will be synchronized when your connection is restored.");
                        
                        // Reset form
                        $form[0].reset();
                        
                        // Reset Select2
                        $form.find('.select2-hidden-accessible').val(null).trigger('change');
                        
                        // Apply optimistic updates to UI
                        applyOptimisticUpdate(operationType, formDataObj);
                    })
                    .catch(error => {
                        alert("Error: " + error);
                    });
            } else {
                alert('Error submitting form: ' + errorThrown);
            }
            showLoading(false);
        }
    });
}

// Apply optimistic updates to UI when offline
function applyOptimisticUpdate(operationType, formData) {
    // Generate temporary ID for new items
    const tempId = 'temp_' + new Date().getTime();
    
    switch(operationType) {
        case 'add_account_head':
            // Add to local data
            accountHeads.push({
                id: tempId,
                name: formData.name,
                _temp: true // Mark as temporary
            });
            // Update UI
            populateAccountHeadsDropdown();
            populateAccountHeadsList();
            break;
            
        case 'add_sub_account':
            // Find parent account head
            const accountHead = accountHeads.find(h => h.id == formData.account_head_id);
            subAccounts.push({
                id: tempId,
                name: formData.name,
                sub_name: formData.name,
                account_head_id: formData.account_head_id,
                account_head_name: accountHead ? accountHead.name : 'Unknown',
                _temp: true
            });
            // Update UI
            populateSubAccountsDropdown();
            populateSubAccountsList();
            break;
            
        case 'add_account':
            // Find parent sub account
            const subAccount = subAccounts.find(s => s.id == formData.sub_account_id);
            accounts.push({
                id: tempId,
                name: formData.name,
                sub_account_id: formData.sub_account_id,
                sub_account_name: subAccount ? subAccount.sub_name : 'Unknown',
                account_head_name: subAccount ? subAccount.account_head_name : 'Unknown',
                _temp: true
            });
            // Update UI
            populateAccountsList();
            break;
            
        case 'edit_account':
            // Update in local data
            if (formData.edit_type === 'account_head') {
                const head = accountHeads.find(h => h.id == formData.edit_id);
                if (head) {
                    head.name = formData.edit_name;
                    head._edited = true;
                }
                populateAccountHeadsList();
            } else if (formData.edit_type === 'sub_account') {
                const sub = subAccounts.find(s => s.id == formData.edit_id);
                if (sub) {
                    sub.name = formData.edit_name;
                    sub.sub_name = formData.edit_name;
                    sub._edited = true;
                }
                populateSubAccountsList();
            } else if (formData.edit_type === 'account') {
                const account = accounts.find(a => a.id == formData.edit_id);
                if (account) {
                    account.name = formData.edit_name;
                    account._edited = true;
                }
                populateAccountsList();
            }
            break;
            
        case 'delete_id':
            // Mark as deleted in local data
            if (formData.delete_type === 'account_head') {
                const index = accountHeads.findIndex(h => h.id == formData.delete_id);
                if (index !== -1) {
                    accountHeads.splice(index, 1);
                }
                populateAccountHeadsList();
                populateAccountHeadsDropdown();
            } else if (formData.delete_type === 'sub_account') {
                const index = subAccounts.findIndex(s => s.id == formData.delete_id);
                if (index !== -1) {
                    subAccounts.splice(index, 1);
                }
                populateSubAccountsList();
                populateSubAccountsDropdown();
            } else if (formData.delete_type === 'account') {
                const index = accounts.findIndex(a => a.id == formData.delete_id);
                if (index !== -1) {
                    accounts.splice(index, 1);
                }
                populateAccountsList();
            }
            break;
    }
}

// Override deleteItem to handle offline mode
function deleteItem(id, type) {
    if (isOnline) {
        // Online deletion - use original method
        $.ajax({
            url: 'index.php',
            type: 'POST',
            data: {
                delete_id: id,
                delete_type: type,
                ajax: true
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    refreshData(); // Refresh data and cache
                } else {
                    alert('Error: ' + response.error);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // Handle connection loss during delete
                if (textStatus === 'timeout' || textStatus === 'error' || jqXHR.status === 0) {
                    isOnline = false;
                    updateOfflineStatusIndicator();
                    
                    // Store operation for later sync
                    storeOfflineOperation('delete_id', {
                        delete_id: id,
                        delete_type: type
                    })
                        .then(() => {
                            alert("Connection lost. Your deletion will be synchronized when your connection is restored.");
                            
                            // Apply optimistic updates to UI
                            applyOptimisticUpdate('delete_id', {
                                delete_id: id,
                                delete_type: type
                            });
                        })
                        .catch(error => {
                            alert("Error: " + error);
                        });
                } else {
                    alert('Error deleting item: ' + errorThrown);
                }
            },
            complete: function() {
                closeDeleteModal();
            }
        });
    } else {
        // Offline deletion - store for later
        storeOfflineOperation('delete_id', {
            delete_id: id,
            delete_type: type
        })
            .then(() => {
                alert("You're offline. This deletion will be synchronized when your connection is restored.");
                
                // Apply optimistic updates to UI
                applyOptimisticUpdate('delete_id', {
                    delete_id: id,
                    delete_type: type
                });
                
                closeDeleteModal();
            })
            .catch(error => {
                alert("Error: " + error);
                closeDeleteModal();
            });
    }
}

// Modify population functions to highlight temporary/edited items
function populateAccountHeadsList() {
    const list = $('#accountHeadsList');
    list.empty();
    
    accountHeads.forEach(head => {
        // Add special class for temporary or edited items
        let itemClass = '';
        if (head._temp) itemClass = 'temp-item';
        if (head._edited) itemClass = 'edited-item';
        
        const isLocked = isLockedAccountHead(head.id);
        const actions = isLocked ? 
            `<span class="action-info locked"><i class="fas fa-lock"></i> System Default</span>` :
            `<button type="button" class="btn-edit" onclick="openEditModal(${head.id}, 'account_head', '${escapeHtml(head.name)}')">
                <i class="fas fa-edit"></i> Edit
            </button>
            <button type="button" class="btn-delete" onclick="showDeleteConfirmation(${head.id}, 'account_head', '${escapeHtml(head.name)}')">
                <i class="fas fa-trash"></i> Delete
            </button>`;
        
        list.append(`
            <li class="${itemClass}">
                <div class="item-details">
                    <span class="item-name">${escapeHtml(head.name)}</span>
                </div>
                <div class="item-actions">
                    ${actions}
                </div>
            </li>
        `);
    });
}

// Populate sub accounts list
function populateSubAccountsList() {
    const list = $('#subAccountsList');
    list.empty();
    
    subAccounts.forEach(subAccount => {
        // Add special class for temporary or edited items
        let itemClass = '';
        if (subAccount._temp) itemClass = 'temp-item';
        if (subAccount._edited) itemClass = 'edited-item';
        
        const isLocked = isLockedSubAccount(subAccount.id);
        const actions = isLocked ? 
            `<span class="action-info locked"><i class="fas fa-lock"></i> System Default</span>` :
            `<button type="button" class="btn-edit" onclick="openEditModal(${subAccount.id}, 'sub_account', '${escapeHtml(subAccount.sub_name)}')">
                <i class="fas fa-edit"></i> Edit
            </button>
            <button type="button" class="btn-delete" onclick="showDeleteConfirmation(${subAccount.id}, 'sub_account', '${escapeHtml(subAccount.sub_name)}')">
                <i class="fas fa-trash"></i> Delete
            </button>`;
        
        list.append(`
            <li class="${itemClass}">
                <div class="item-details">
                    <span class="item-name">${escapeHtml(subAccount.sub_name)}</span>
                    <span class="item-parent">
                        <span class="parent-label">Account Head:</span>
                        <span class="parent-value">${escapeHtml(subAccount.account_head_name)}</span>
                    </span>
                </div>
                <div class="item-actions">
                    ${actions}
                </div>
            </li>
        `);
    });
}

// Populate accounts list
function populateAccountsList() {
    const list = $('#accountsList');
    list.empty();
    
    accounts.forEach(account => {
        // Add special class for temporary or edited items
        let itemClass = '';
        if (account._temp) itemClass = 'temp-item';
        if (account._edited) itemClass = 'edited-item';
        
        const isLocked = isLockedAccount(account.id);
        const actions = isLocked ? 
            `<span class="action-info locked"><i class="fas fa-lock"></i> System Default</span>` :
            `<button type="button" class="btn-edit" onclick="openEditModal(${account.id}, 'account', '${escapeHtml(account.name)}')">
                <i class="fas fa-edit"></i> Edit
            </button>
            <button type="button" class="btn-delete" onclick="showDeleteConfirmation(${account.id}, 'account', '${escapeHtml(account.name)}')">
                <i class="fas fa-trash"></i> Delete
            </button>`;
        
        list.append(`
            <li class="${itemClass}">
                <div class="item-details">
                    <span class="item-name">${escapeHtml(account.name)}</span>
                    <span class="item-parent">
                        <span class="parent-label">Category:</span>
                        <span class="parent-value">${escapeHtml(account.account_head_name)}</span>
                        <span class="parent-separator">></span>
                        <span class="parent-value">${escapeHtml(account.sub_account_name)}</span>
                    </span>
                </div>
                <div class="item-actions">
                    ${actions}
                </div>
            </li>
        `);
    });
}

// Populate account heads dropdown
function populateAccountHeadsDropdown() {
    const dropdown = $('#account_head_id');
    dropdown.empty();
    
    accountHeads.forEach(head => {
        dropdown.append($('<option>', {
            value: head.id,
            text: head.name
        }));
    });
    
    // Refresh Select2
    dropdown.trigger('change');
}

// Populate sub accounts dropdown
function populateSubAccountsDropdown() {
    const dropdown = $('#sub_account_id');
    dropdown.empty();
    
    subAccounts.forEach(subAccount => {
        dropdown.append($('<option>', {
            value: subAccount.id,
            text: subAccount.sub_name
        }));
    });
    
    // Refresh Select2
    dropdown.trigger('change');
}

// Helper function to check if account head is locked (system default)
function isLockedAccountHead(id) {
    const lockedIds = [1, 2, 3, 4, 5]; // IDs of locked account heads
    return lockedIds.includes(parseInt(id));
}

// Helper function to check if sub account is locked (system default)
function isLockedSubAccount(id) {
    // IDs 1-31 are locked
    return parseInt(id) >= 1 && parseInt(id) <= 31;
}

// Helper function to check if account is locked (system default)
function isLockedAccount(id) {
    const lockedIds = [1, 2, 3, 4]; // IDs of locked accounts
    return lockedIds.includes(parseInt(id));
}

// Helper function to escape HTML to prevent XSS
function escapeHtml(unsafe) {
    return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// Search functionality
function performSearch(type) {
    const searchInput = document.getElementById('search' + type).value.toLowerCase();
    const itemsList = document.getElementById(type === 'Heads' ? 'accountHeadsList' : (type === 'Subs' ? 'subAccountsList' : 'accountsList'));
    const items = itemsList.getElementsByTagName('li');
    
    for (let i = 0; i < items.length; i++) {
        const itemText = items[i].textContent.toLowerCase();
        if (itemText.includes(searchInput)) {
            items[i].style.display = '';
        } else {
            items[i].style.display = 'none';
        }
    }
}

function cancelSearch(type) {
    document.getElementById('search' + type).value = '';
    const itemsList = document.getElementById(type === 'Heads' ? 'accountHeadsList' : (type === 'Subs' ? 'subAccountsList' : 'accountsList'));
    const items = itemsList.getElementsByTagName('li');
    
    for (let i = 0; i < items.length; i++) {
        items[i].style.display = '';
    }
}

// Edit modal functionality
function openEditModal(id, type, name) {
    document.getElementById('edit_id').value = id;
    document.getElementById('edit_type').value = type;
    document.getElementById('edit_name').value = name;
    document.getElementById('editModal').style.display = 'block';
}

function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
}

// Delete confirmation modal
function showDeleteConfirmation(id, type, name) {
    // First check if the item has dependencies
    $.ajax({
        url: 'index.php',
        type: 'POST',
        data: {
            check_dependencies: true,
            delete_id: id,
            delete_type: type,
            ajax: true
        },
        dataType: 'json',
        success: function(response) {
            if (response.has_dependencies) {
                alert(response.error);
            } else {
                // No dependencies, show confirmation dialog
                let itemType = type === 'account_head' ? 'Account Head' : (type === 'sub_account' ? 'Sub Account' : 'Account');
                document.getElementById('deleteConfirmationText').textContent = `Are you sure you want to delete the ${itemType} "${name}"?`;
                
                // Set up the confirm button to perform the delete
                document.getElementById('confirmDeleteBtn').onclick = function() {
                    deleteItem(id, type);
                };
                
                document.getElementById('deleteConfirmationModal').style.display = 'block';
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('Error checking dependencies: ' + errorThrown);
        }
    });
}

function closeDeleteModal() {
    document.getElementById('deleteConfirmationModal').style.display = 'none';
}

function confirmDelete() {
    // The actual delete is handled by the onclick handler set in showDeleteConfirmation
}

// Override deleteItem to refresh cache after successful deletion
function deleteItem(id, type) {
    $.ajax({
        url: 'index.php',
        type: 'POST',
        data: {
            delete_id: id,
            delete_type: type,
            ajax: true
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                alert(response.message);
                refreshData(); // Refresh data and cache
            } else {
                alert('Error: ' + response.error);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('Error deleting item: ' + errorThrown);
        },
        complete: function() {
            closeDeleteModal();
        }
    });
}

// When an item is added, edited, or deleted, refresh the cache
function refreshData() {
    // Force fetch from server to update cache
    fetchData(true);
}

// Add form submission handling for AJAX form submission
$(document).ready(function() {
    // Handle form submissions via AJAX
    $('form').on('submit', function(e) {
        // Skip AJAX for forms that need to do a full postback
        if ($(this).hasClass('no-ajax')) {
            return true;
        }
        
        e.preventDefault();
        
        // Show loading indicator
        showLoading(true);
        
        // Submit form via AJAX
        $.ajax({
            url: $(this).attr('action'),
            type: $(this).attr('method'),
            data: $(this).serialize() + '&ajax=true',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    refreshData(); // Refresh data and cache
                    
                    // Reset form
                    $('form').each(function() {
                        this.reset();
                    });
                    
                    // Reset Select2
                    $('.select2-hidden-accessible').val(null).trigger('change');
                } else {
                    alert('Error: ' + response.error);
                }
                showLoading(false);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('Error submitting form: ' + errorThrown);
                showLoading(false);
            }
        });
    });
    
    // Add refresh button functionality
    $('#refreshData').on('click', function() {
        refreshData();
    });
});