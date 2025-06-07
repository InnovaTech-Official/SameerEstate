/**
 * Navbar Navigation Functionality
 * This file contains common navigation functionality used across the application
 */

// Define base path for the application
const BASE_PATH = '/realestate';

// Check if jQuery is available and use it, otherwise fallback to vanilla JS
if (typeof jQuery !== 'undefined') {
    $(document).ready(function () {
        // Initialize dynamic base path
        const dynamicBasePath = getBasePath();
        
        // Navbar button click handler
        $('.nav-btn').on('click', function () {
            const section = $(this).data('section');
            navigateTo(section);
            
            // Remove active class from all buttons
            $('.nav-btn').removeClass('active');
            
            // Add active class to clicked button
            $(this).addClass('active');
        });

        // Mobile menu toggle
        $('.mobile-menu-btn').on('click', function () {
            $('.nav-left').toggleClass('show');
            const expanded = $(this).attr('aria-expanded') === 'true' || false;
            $(this).attr('aria-expanded', !expanded);
        });

        // Logout button handler
        $('#logout-btn').on('click', function () {
            window.location.href = dynamicBasePath + '/logout.php';
        });
        
        // Highlight current page
        highlightCurrentPage();
    });
} else {
    // Vanilla JS implementation
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize dynamic base path
        const dynamicBasePath = getBasePath();
        
        // Get all navigation buttons
        const navButtons = document.querySelectorAll('.nav-btn');
        
        // Add click event listener to each button
        navButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                navButtons.forEach(btn => btn.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Get the section name from data attribute
                const section = this.getAttribute('data-section');
                
                // Navigate to the corresponding page based on section
                navigateToSection(section);
            });
        });
        
        // Mobile menu toggle
        const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
        if (mobileMenuBtn) {
            mobileMenuBtn.addEventListener('click', function() {
                const navLeft = document.querySelector('.nav-left');
                navLeft.classList.toggle('show');
                
                const expanded = this.getAttribute('aria-expanded') === 'true' || false;
                this.setAttribute('aria-expanded', !expanded);
            });
        }
        
        // Highlight the current active button based on the current page
        highlightCurrentPage();
        
        // Handle logout button
        const logoutBtn = document.getElementById('logout-btn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', function() {
                window.location.href = dynamicBasePath + '/logout.php';
            });
        }
    });
}

/**
 * Function to handle navigation between different sections (jQuery version)
 * @param {string} section - The section identifier to navigate to
 */
function navigateTo(section) {
    // Get the dynamic base path
    const dynamicBasePath = getBasePath();
    
    // Handle navigation based on section
    switch (section) {
        case 'home':
            window.location.href = dynamicBasePath + '/controllers/dashboard/dashboard.php';
            break;
        case 'customer':
            window.location.href = dynamicBasePath + '/controllers/reports/customerList/index.php';
            break;
        case 'seller':
            window.location.href = dynamicBasePath + '/controllers/setup/sellersetup/index.php';
            break;
        case 'purchaser':
            window.location.href = dynamicBasePath + '/controllers/setup/purchasersetup/index.php';
            break;
        case 'project':
            window.location.href = dynamicBasePath + '/controllers/setup/projectsetup/index.php';
            break;
        case 'tenant':
            window.location.href = dynamicBasePath + '/controllers/setup/tenantsetup/index.php';
            break;
        case 'rentowner':
            window.location.href = dynamicBasePath + '/controllers/setup/rentownersetup/index.php';
            break;
        case 'rentagreement':
            window.location.href = dynamicBasePath + '/controllers/agreement/rentagreement/index.php';
            break;
        case 'saleagreement':
            window.location.href = dynamicBasePath + '/controllers/agreement/saleagreement/index.php';
            break;
        case 'tracking':
            window.location.href = dynamicBasePath + '/controllers/tracking/index.php';
            break;
        case 'wishlist':
            window.location.href = dynamicBasePath + '/controllers/wishlist/index.php';
            break;
        case 'receivevoucher':
            window.location.href = dynamicBasePath + '/controllers/voucher/receive/index.php';
            break;
        case 'paymentvoucher':
            window.location.href = dynamicBasePath + '/controllers/voucher/payment/index.php';
            break;
        case 'expensevoucher':
            window.location.href = dynamicBasePath + '/controllers/voucher/expense/index.php';
            break;
        case 'journalvoucher':
            window.location.href = dynamicBasePath + '/controllers/voucher/journal/index.php';
            break;
        case 'setup':
            window.location.href = dynamicBasePath + '/controllers/setup/index.php';
            break;
        case 'hr':
            window.location.href = dynamicBasePath + '/controllers/hr/index.php';
            break;
        case 'settings':
            window.location.href = dynamicBasePath + '/controllers/settings/index.php';
            break;
        default:
            console.log('Unknown section:', section);
    }
}

/**
 * Function to navigate to different sections (Vanilla JS version)
 * @param {string} section - The section identifier to navigate to
 */
function navigateToSection(section) {
    // Use the same paths as the jQuery version for consistency
    navigateTo(section);
}

/**
 * Function to highlight the current page in the navigation
 */
function highlightCurrentPage() {
    // Get current page path
    const currentPath = window.location.pathname;
    
    if (typeof jQuery !== 'undefined') {
        // jQuery version
        $('.nav-btn').each(function() {
            const section = $(this).data('section');
            if (currentPath.includes(`/${section}/`) || 
                (section === 'home' && currentPath.includes('/dashboard/'))) {
                $(this).addClass('active');
            }
        });
    } else {
        // Vanilla JS version
        const navButtons = document.querySelectorAll('.nav-btn');
        navButtons.forEach(button => {
            const section = button.getAttribute('data-section');
            if (currentPath.includes(`/${section}/`) || 
                (section === 'home' && currentPath.includes('/dashboard/'))) {
                button.classList.add('active');
            }
        });
    }
}

/**
 * Function to determine the base path dynamically
 * This handles cases where the application might be accessed from different directories
 */
function getBasePath() {
    // This is a more robust way to get the base path
    // It extracts the application path from the current script path
    const scripts = document.getElementsByTagName('script');
    for (let i = 0; i < scripts.length; i++) {
        const src = scripts[i].src;
        if (src.includes('/assets/js/common/navigation.js')) {
            // Extract the base path by removing everything after "/assets"
            return src.split('/assets')[0];
        }
    }
    // Fallback to the default BASE_PATH if we couldn't determine it dynamically
    return BASE_PATH;
}