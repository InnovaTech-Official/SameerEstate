<?php
/**
 * Search functionality for customer list
 * This file handles all search parameters and builds the query for customer listing
 */

/**
 * Process search parameters and build WHERE clause for customer search
 * 
 * @param array $requestParams Usually $_GET parameters
 * @return array Returns an associative array with 'where', 'params', and other search parameters
 */
function processCustomerSearch($requestParams = []) {
    // Get search parameters
    $search = isset($requestParams['search']) ? $requestParams['search'] : '';
    $cellSearch = isset($requestParams['cell_search']) ? $requestParams['cell_search'] : '';
    $cnicSearch = isset($requestParams['cnic_search']) ? $requestParams['cnic_search'] : '';
    $leadId = isset($requestParams['lead_id']) ? $requestParams['lead_id'] : '';
    $religionId = isset($requestParams['religion_id']) ? $requestParams['religion_id'] : '';
    $maritalStatusId = isset($requestParams['marital_status_id']) ? $requestParams['marital_status_id'] : '';
    $dateFrom = isset($requestParams['date_from']) ? $requestParams['date_from'] : '';
    $dateTo = isset($requestParams['date_to']) ? $requestParams['date_to'] : '';
    $page = isset($requestParams['page']) && is_numeric($requestParams['page']) ? (int)$requestParams['page'] : 1;
    $limit = isset($requestParams['limit']) && is_numeric($requestParams['limit']) ? (int)$requestParams['limit'] : 10;
    $offset = ($page - 1) * $limit;

    // Build the WHERE clause
    $where = [];
    $params = [];

    if (!empty($search)) {
        $where[] = "(c.name LIKE ? OR c.email LIKE ? OR c.company LIKE ?)";
        $params[] = "%$search%";
        $params[] = "%$search%";
        $params[] = "%$search%";
    }

    if (!empty($cellSearch)) {
        $where[] = "cn.cell_no LIKE ?";
        $params[] = "%$cellSearch%";
    }

    if (!empty($cnicSearch)) {
        $where[] = "c.cnic LIKE ?";
        $params[] = "%$cnicSearch%";
    }

    if (!empty($leadId)) {
        $where[] = "c.lead_id = ?";
        $params[] = $leadId;
    }

    if (!empty($religionId)) {
        $where[] = "c.religion_id = ?";
        $params[] = $religionId;
    }

    if (!empty($maritalStatusId)) {
        $where[] = "c.marital_status_id = ?";
        $params[] = $maritalStatusId;
    }

    if (!empty($dateFrom)) {
        $where[] = "DATE(c.created_at) >= ?";
        $params[] = $dateFrom;
    }

    if (!empty($dateTo)) {
        $where[] = "DATE(c.created_at) <= ?";
        $params[] = $dateTo;
    }

    $whereClause = !empty($where) ? "WHERE " . implode(" AND ", $where) : "";

    // Return all search parameters and the built WHERE clause
    return [
        'search' => $search,
        'cellSearch' => $cellSearch,
        'cnicSearch' => $cnicSearch,
        'leadId' => $leadId,
        'religionId' => $religionId,
        'maritalStatusId' => $maritalStatusId,
        'dateFrom' => $dateFrom,
        'dateTo' => $dateTo,
        'page' => $page,
        'limit' => $limit,
        'offset' => $offset,
        'where' => $whereClause,
        'params' => $params,
        'hasSearchParams' => !empty($where) // Flag to indicate if any search parameters were applied
    ];
}

/**
 * Helper function to generate query parameters for pagination links
 * 
 * @param array $requestParams Usually $_GET parameters
 * @param bool $includePage Whether to include page parameter
 * @return string Query string for URLs
 */
function getQueryParams($requestParams = [], $includePage = true) {
    $params = [];
    $allowedParams = ['search', 'cell_search', 'cnic_search', 'lead_id', 'religion_id', 
                      'marital_status_id', 'date_from', 'date_to', 'limit'];
    
    if ($includePage && isset($requestParams['page']) && is_numeric($requestParams['page'])) {
        $params[] = 'page=' . intval($requestParams['page']);
    }
    
    foreach ($allowedParams as $param) {
        if (isset($requestParams[$param]) && $requestParams[$param] !== '') {
            $params[] = $param . '=' . urlencode($requestParams[$param]);
        }
    }
    
    return !empty($params) ? '&' . implode('&', $params) : '';
}

/**
 * Generate pagination data for the frontend
 * 
 * @param int $totalRecords Total number of records
 * @param int $currentPage Current page number
 * @param int $perPage Number of records per page
 * @return array Pagination data
 */
function generatePaginationData($totalRecords, $currentPage, $perPage) {
    $totalPages = ceil($totalRecords / $perPage);
    $currentPage = max(1, min($currentPage, $totalPages)); // Ensure page is within range
    
    $startRecord = ($currentPage - 1) * $perPage + 1;
    $endRecord = min($startRecord + $perPage - 1, $totalRecords);
    
    // If no records, adjust start to 0
    if ($totalRecords === 0) {
        $startRecord = 0;
        $endRecord = 0;
    }
    
    return [
        'totalRecords' => $totalRecords,
        'totalPages' => $totalPages,
        'currentPage' => $currentPage,
        'perPage' => $perPage,
        'startRecord' => $startRecord,
        'endRecord' => $endRecord
    ];
}