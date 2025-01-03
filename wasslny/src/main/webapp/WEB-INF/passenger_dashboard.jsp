<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Dashboard | Wasslny</title>
    <link rel="icon" type="image/x-icon" href="/css/imgs/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .nav-link {
            color: #333;
            padding: 0.8rem 1rem;
            margin: 0.2rem 0;
            border-radius: 0.5rem;
        }
        .nav-link:hover, .nav-link.active {
            background-color: #f8f9fa;
            color: #0d6efd;
        }
        .main-content {
            margin-left: 280px;
            padding: 2rem;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar bg-white p-4 position-fixed" style="width: 280px;">
            <div class="text-center mb-4">
                <img src="/css/imgs/icon.png" alt="Profile" class="rounded-circle mb-3" width="100">
                <h5 class="mb-0">${loggedUser.firstName} ${loggedUser.lastName}</h5>
                <p class="text-muted">Passenger</p>
            </div>

            <nav class="nav flex-column">
                <a class="nav-link active" href="/passenger/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a class="nav-link" href="/user/profile/edit">
                    <i class="bi bi-person-gear"></i> Edit Profile
                </a>
                <a class="nav-link" href="/passenger/find/trips">
                    <i class="bi bi-search"></i> Find Trips
                </a>
                <a class="nav-link text-danger" href="/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content flex-grow-1">
            <!-- Upcoming Trips Section -->
            <div class="card mb-4">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-car-front"></i> Your Upcoming Trips</h5>
                    <a href="/passenger/find/trips" class="btn btn-light btn-sm">
                        <i class="bi bi-search"></i> Find New Trips
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Route</th>
                                    <th>Status</th>
                                    <th>Passengers</th>
                                    <th>Departure</th>
                                    <th>Driver</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trip" items="${trips}">
                                    <c:if test="${trip.status == 'Planned'}">
                                        <tr>
                                            <td>
                                                <a href="/passenger/trips/${trip.id}" class="text-decoration-none">
                                                    ${trip.title}
                                                </a>
                                            </td>
                                            <td>${trip.description}</td>
                                            <td>
                                                <small class="text-muted">
                                                    <i class="bi bi-geo-alt"></i> ${trip.startPoint} →
                                                    <i class="bi bi-geo"></i> ${trip.destination}
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-warning">${trip.status}</span>
                                            </td>
                                            <td>
                                                <i class="bi bi-people"></i> ${trip.currentPassengers}/${trip.maximumPassengers}
                                            </td>
                                            <td>
                                                <i class="bi bi-clock"></i> ${trip.departureTime}
                                            </td>
                                            <td>${trip.driver.firstName} ${trip.driver.lastName}</td>
                                            <td>
                                                <form method="post" action="/passenger/trips/${trip.id}/leave">
                                                    <input type="hidden" name="tripId" value="${trip.id}">
                                                    <button type="submit" class="btn btn-danger btn-sm">
                                                        <i class="bi bi-x-circle"></i> Leave
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty trips}">
                            <div class="text-center py-4">
                                <i class="bi bi-calendar-x h1 text-muted"></i>
                                <p class="text-muted">You have not joined any trips yet</p>
                                <a href="/passenger/find/trips" class="btn btn-primary">
                                    <i class="bi bi-search"></i> Find Trips
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Past Trips Section -->
            <div class="card">
                <div class="card-header bg-secondary text-white">
                    <h5 class="mb-0"><i class="bi bi-clock-history"></i> Past Trips</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Route</th>
                                    <th>Status</th>
                                    <th>Passengers</th>
                                    <th>Departure</th>
                                    <th>Driver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trip" items="${trips}">
                                    <c:if test="${trip.status == 'Departed'}">
                                        <tr>

                                            <td>
												<a href="/passenger/trips/${trip.id}" class="text-decoration-none text-primary d-flex align-items-center">
													<i class="bi bi-card-text me-2"></i>
													<span class="fw-medium">${trip.title}</span>
												</a>
											</td>
                                            <td>${trip.description}</td>
                                            <td>
                                                <small class="text-muted">
                                                    <i class="bi bi-geo-alt"></i> ${trip.startPoint} →
                                                    <i class="bi bi-geo"></i> ${trip.destination}
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-success">${trip.status}</span>
                                            </td>
                                            <td>
                                                <i class="bi bi-people"></i> ${trip.currentPassengers}/${trip.maximumPassengers}
                                            </td>
                                            <td>
                                                <i class="bi bi-clock"></i> ${trip.departureTime}
                                            </td>
                                            <td>${trip.driver.firstName} ${trip.driver.lastName}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty trips}">
                            <div class="text-center py-4">
                                <i class="bi bi-calendar-x h1 text-muted"></i>
                                <p class="text-muted">No past trips found</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>