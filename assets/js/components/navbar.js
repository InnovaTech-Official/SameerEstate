/**
 * Navbar Component
 * This file creates a reusable navbar component that can be injected into any page
 */

/**
 * Creates and renders the navigation bar
 * @param {string} containerId - The ID of the container to render the navbar into
 * @param {string} activeSection - The currently active section (optional)
 */
function renderNavbar(containerId = 'navbar-container', activeSection = null) {
    const container = document.getElementById(containerId);
    if (!container) {
        console.error(`Container with ID "${containerId}" not found`);
        return;
    }

    // If no active section provided, attempt to determine it from the URL
    if (!activeSection) {
        activeSection = determineActiveSection();
    }

    // Create the navigation HTML
    const navbarHTML = `
    <nav role="navigation" aria-label="Dashboard Navigation" class="expanded">
        <div class="nav-header">
            <button class="mobile-menu-btn" aria-label="Toggle menu" aria-expanded="false">
                <i class="fas fa-bars"></i>
            </button>
            <button class="toggle-sidebar-btn" aria-label="Toggle sidebar" title="Toggle sidebar">
                <i class="fas fa-chevron-left"></i>
            </button>
        </div>
        <div class="nav-left">
            <button class="nav-btn ${activeSection === 'home' ? 'active' : ''}" data-section="home" title="Home">
                <i class="fas fa-home"></i> <span class="nav-text">Home</span>
            </button>
            <button class="nav-btn ${activeSection === 'customer' ? 'active' : ''}" data-section="customer" title="Customer">
                <i class="fas fa-user-friends"></i> <span class="nav-text">Customer</span>
            </button>
            <button class="nav-btn ${activeSection === 'seller' ? 'active' : ''}" data-section="seller" title="Seller">
                <i class="fas fa-store"></i> <span class="nav-text">Seller</span>
            </button>
            <button class="nav-btn ${activeSection === 'purchaser' ? 'active' : ''}" data-section="purchaser" title="Purchaser">
                <i class="fas fa-user-tag"></i> <span class="nav-text">Purchaser</span>
            </button>
            <button class="nav-btn ${activeSection === 'project' ? 'active' : ''}" data-section="project" title="Project">
                <i class="fas fa-project-diagram"></i> <span class="nav-text">Project</span>
            </button>
            <button class="nav-btn ${activeSection === 'tenant' ? 'active' : ''}" data-section="tenant" title="Tenant">
                <i class="fas fa-house-user"></i> <span class="nav-text">Tenant</span>
            </button>
            <button class="nav-btn ${activeSection === 'rentowner' ? 'active' : ''}" data-section="rentowner" title="Rent Owner">
                <i class="fas fa-key"></i> <span class="nav-text">Rent Owner</span>
            </button>
            <button class="nav-btn ${activeSection === 'rentagreement' ? 'active' : ''}" data-section="rentagreement" title="Rent Agreement">
                <i class="fas fa-file-signature"></i> <span class="nav-text">Rent Agreement</span>
            </button>
            <button class="nav-btn ${activeSection === 'saleagreement' ? 'active' : ''}" data-section="saleagreement" title="Sale Agreement">
                <i class="fas fa-file-contract"></i> <span class="nav-text">Sale Agreement</span>
            </button>
            <button class="nav-btn ${activeSection === 'tracking' ? 'active' : ''}" data-section="tracking" title="Tracking">
                <i class="fas fa-chart-line"></i> <span class="nav-text">Tracking</span>
            </button>
            <button class="nav-btn ${activeSection === 'wishlist' ? 'active' : ''}" data-section="wishlist" title="WishList">
                <i class="fas fa-heart"></i> <span class="nav-text">WishList</span>
            </button>
            <button class="nav-btn ${activeSection === 'receivevoucher' ? 'active' : ''}" data-section="receivevoucher" title="Receive Voucher">
                <i class="fas fa-hand-holding-usd"></i> <span class="nav-text">Receive Voucher</span>
            </button>
            <button class="nav-btn ${activeSection === 'paymentvoucher' ? 'active' : ''}" data-section="paymentvoucher" title="Payment Voucher">
                <i class="fas fa-money-bill-wave"></i> <span class="nav-text">Payment Voucher</span>
            </button>
            <button class="nav-btn ${activeSection === 'expensevoucher' ? 'active' : ''}" data-section="expensevoucher" title="Expense Voucher">
                <i class="fas fa-funnel-dollar"></i> <span class="nav-text">Expense Voucher</span>
            </button>
            <button class="nav-btn ${activeSection === 'journalvoucher' ? 'active' : ''}" data-section="journalvoucher" title="Journal Voucher">
                <i class="fas fa-book-open"></i> <span class="nav-text">Journal Voucher</span>
            </button>
            <button class="nav-btn ${activeSection === 'setup' ? 'active' : ''}" data-section="setup" title="Setup">
                <i class="fas fa-tools"></i> <span class="nav-text">Setup</span>
            </button>
            <button class="nav-btn ${activeSection === 'hr' ? 'active' : ''}" data-section="hr" title="HR">
                <i class="fas fa-users-cog"></i> <span class="nav-text">HR</span>
            </button>
            <button class="nav-btn ${activeSection === 'settings' ? 'active' : ''}" data-section="settings" title="Settings">
                <i class="fas fa-cog"></i> <span class="nav-text">Settings</span>
            </button>
            <button id="logout-btn" title="Logout">
                <i class="fas fa-sign-out-alt"></i> <span class="nav-text">Logout</span>
            </button>
        </div>
    </nav>
    `;

    // Insert the navbar HTML into the container
    container.innerHTML = navbarHTML;

    // Initialize the navbar functionality
    initNavbarFunctionality();
}

/**
 * Initializes the navbar event listeners and functionality
 */
function initNavbarFunctionality() {
    // Get all navigation buttons
    const navButtons = document.querySelectorAll('.nav-btn');
    
    // Add click event listener to each button
    navButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons
            navButtons.forEach(btn => btn.classList.remove('active'));
            
            // Add active class to the clicked button
            this.classList.add('active');
            
            // Get the section name from data attribute
            const section = this.getAttribute('data-section');
            
            // Navigate to the corresponding page
            navigateTo(section);
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
    
    // Sidebar toggle button
    const toggleSidebarBtn = document.querySelector('.toggle-sidebar-btn');
    if (toggleSidebarBtn) {
        toggleSidebarBtn.addEventListener('click', function() {
            const nav = document.querySelector('nav');
            nav.classList.toggle('collapsed');
            
            // Toggle the icon direction
            const icon = this.querySelector('i');
            if (nav.classList.contains('collapsed')) {
                icon.classList.replace('fa-chevron-left', 'fa-chevron-right');
                localStorage.setItem('sidebar-collapsed', 'true');
            } else {
                icon.classList.replace('fa-chevron-right', 'fa-chevron-left');
                localStorage.setItem('sidebar-collapsed', 'false');
            }
            
            // Dispatch event for other scripts to handle layout adjustments
            window.dispatchEvent(new CustomEvent('sidebar-toggle', {
                detail: { collapsed: nav.classList.contains('collapsed') }
            }));
        });
    }
    
    // Handle logout button
    const logoutBtn = document.getElementById('logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', function() {
            const basePath = getBasePath();
            window.location.href = basePath + '/logout.php';
        });
    }
    
    // Check if sidebar was collapsed in previous session
    if (localStorage.getItem('sidebar-collapsed') === 'true') {
        document.querySelector('nav').classList.add('collapsed');
        const icon = document.querySelector('.toggle-sidebar-btn i');
        if (icon) {
            icon.classList.replace('fa-chevron-left', 'fa-chevron-right');
        }
    }
    
    // Auto-collapse sidebar on smaller screens
    const autoCollapseSidebar = () => {
        if (window.innerWidth < 1200 && window.innerWidth >= 768) {
            document.querySelector('nav').classList.add('collapsed');
            const icon = document.querySelector('.toggle-sidebar-btn i');
            if (icon) {
                icon.classList.replace('fa-chevron-left', 'fa-chevron-right');
            }
        }
    };
    
    // Run on load
    autoCollapseSidebar();
    
    // Run on window resize
    window.addEventListener('resize', autoCollapseSidebar);
}

/**
 * Determines the active section based on the current URL path
 * @returns {string|null} The active section name or null if not determined
 */
function determineActiveSection() {
    const currentPath = window.location.pathname;
    
    // Special cases mapping - paths that don't directly match section names
    const specialPaths = {
        '/dashboard/': 'home',
        '/reports/customerList/': 'customer'
    };
    
    // Check special paths first
    for (const path in specialPaths) {
        if (currentPath.includes(path)) {
            return specialPaths[path];
        }
    }
    
    // List of all possible sections
    const sections = [
        'home', 'customer', 'seller', 'purchaser', 'project', 'tenant', 
        'rentowner', 'rentagreement', 'saleagreement', 'tracking', 'wishlist',
        'receivevoucher', 'paymentvoucher', 'expensevoucher', 'journalvoucher',
        'setup', 'hr', 'settings'
    ];
    
    // Check if the current path contains any of the section names
    for (const section of sections) {
        if (currentPath.includes(`/${section}/`)) {
            return section;
        }
    }
    
    return null;
}

// Auto-initialize the navbar if the container exists when the script loads
document.addEventListener('DOMContentLoaded', function() {
    const defaultContainer = document.getElementById('navbar-container');
    if (defaultContainer) {
        renderNavbar('navbar-container');
    }
});