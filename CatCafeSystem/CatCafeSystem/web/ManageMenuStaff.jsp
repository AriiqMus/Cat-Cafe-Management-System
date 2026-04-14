<%@page import="model.Menu"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Menu Management</title>
        <link rel="stylesheet" href="styleMenu2.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp">
            <jsp:param name="page" value="editCat" />
        </jsp:include>
        
        <div class="container">
            <h1 class="page-title">Menu Management</h1>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <!-- Add New Menu Form -->
            <h2 class="section-title">Add New Menu Item</h2>
            <div class="form-container">
                <form method="POST" action="StaffMenuServlet" enctype="multipart/form-data" id="addForm">
                    <input type="hidden" name="action" value="add">

                    <div class="form-group">
                        <label class="form-label">Name:</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Price:</label>
                        <input type="number" step="0.01" name="price" class="form-control" required min="0.01">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Category:</label>
                        <select name="category" class="form-control" required>
                            <option value="FOOD">Food</option>
                            <option value="BEVERAGE">Beverage</option>
                            <option value="DESSERT">Dessert</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Image:</label>
                        <input type="file" name="image" class="form-control" accept="image/*" required>
                    </div>

                    <div class="form-group form-checkbox-group">
                        <input type="checkbox" name="isAvailable" id="isAvailable" checked>
                        <label for="isAvailable" class="form-label">Available</label>
                    </div>

                    <button type="submit" class="btn btn-primary">Add Menu Item</button>
                </form>
            </div>
            
            <!-- Menu List with Actions -->
            <h2 class="section-title">Current Menu Items</h2>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Category</th>
                            <th>Image</th>
                            <th>Available</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Menu> menuList = (List<Menu>) request.getAttribute("menu");
                            if (menuList != null) {
                                for (Menu menu : menuList) { 
                        %>
                        <tr>
                            <td><%= menu.getMenuID() %></td>
                            <td><%= menu.getName() %></td>
                            <td>RM <%= String.format("%.2f", menu.getPrice()) %></td>
                            <td><%= menu.getCategory() %></td>
                            <td>
                                <% if (menu.getImageUrl() != null && !menu.getImageUrl().isEmpty()) { %>
                                    <img src="${pageContext.request.contextPath}/<%= menu.getImageUrl() %>" 
                                         class="thumbnail" alt="<%= menu.getName() %>">
                                <% } else { %>
                                    No image
                                <% } %>
                            </td>
                            <td class="<%= menu.isIsAvailable() ? "available" : "unavailable" %>">
                                <%= menu.isIsAvailable() ? "Yes" : "No" %>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <button class="btn btn-primary edit-btn" 
                                            data-id="<%= menu.getMenuID() %>"
                                            data-name="<%= menu.getName() %>"
                                            data-price="<%= menu.getPrice() %>"
                                            data-category="<%= menu.getCategory() %>"
                                            data-image="<%= menu.getImageUrl() %>"
                                            data-available="<%= menu.isIsAvailable() %>">
                                        Edit
                                    </button>
                                    <form method="POST" action="StaffMenuServlet">
                                        <input type="hidden" name="action" value="toggleAvailability">
                                        <input type="hidden" name="menuId" value="<%= menu.getMenuID() %>">
                                        <button type="submit" class="btn btn-primary">Toggle</button>
                                    </form>
                                    <form method="POST" action="StaffMenuServlet" onsubmit="return confirm('Are you sure you want to delete this menu item?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="menuId" value="<%= menu.getMenuID() %>">
                                        <button type="submit" class="btn btn-secondary">Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% 
                                }
                            } 
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Edit Modal -->
        <div class="modal" id="editModal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Edit Menu Item</h2>
                <form method="POST" action="StaffMenuServlet" enctype="multipart/form-data" id="editForm">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="menuId" id="editMenuId">
                    
                    <div class="form-group">
                        <label class="form-label">Name:</label>
                        <input type="text" name="name" id="editName" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Price:</label>
                        <input type="number" step="0.01" name="price" id="editPrice" class="form-control" required min="0.01">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Category:</label>
                        <select name="category" id="editCategory" class="form-control" required>
                            <option value="FOOD">Food</option>
                            <option value="BEVERAGE">Beverage</option>
                            <option value="DESSERT">Dessert</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Image:</label>
                        <input type="file" name="image" class="form-control" accept="image/*">
                        <small class="form-text">Leave blank to keep current image</small>
                        <div id="currentImageContainer" style="margin-top: 10px;"></div>
                    </div>

                    <div class="form-group form-checkbox-group">
                        <input type="checkbox" name="isAvailable" id="editIsAvailable">
                        <label for="editIsAvailable" class="form-label">Available</label>
                    </div>

                    <button type="submit" class="btn btn-primary">Update Menu Item</button>
                </form>
            </div>
        </div>
        <script>
            // Form validation for add form
            document.getElementById('addForm').addEventListener('submit', function(e) {
                const priceInput = this.querySelector('input[name="price"]');
                const fileInput = this.querySelector('input[type="file"]');
                
                // Validate price
                if (isNaN(parseFloat(priceInput.value)) || parseFloat(priceInput.value) <= 0) {
                    alert('Price must be a number greater than 0');
                    e.preventDefault();
                    return false;
                }
                
                // Validate file size if new image is being uploaded
                if (fileInput && fileInput.files.length > 0) {
                    const fileSize = fileInput.files[0].size / 1024 / 1024; // in MB
                    if (fileSize > 2) {
                        alert('File size exceeds 2MB limit');
                        e.preventDefault();
                        return false;
                    }
                }
                
                return true;
            });
            
            // Modal handling
            const modal = document.getElementById('editModal');
            const span = document.querySelector('.close');
            
            // When the user clicks on <span> (x), close the modal
            span.onclick = function() {
                modal.style.display = 'none';
            }
            
            // When the user clicks anywhere outside the modal, close it
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            }
            
            // Handle edit button clicks
            document.querySelectorAll('.edit-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const menuId = this.getAttribute('data-id');
                    const name = this.getAttribute('data-name');
                    const price = this.getAttribute('data-price');
                    const category = this.getAttribute('data-category');
                    const imageUrl = this.getAttribute('data-image');
                    const isAvailable = this.getAttribute('data-available') === 'true';
                    
                    // Populate the form
                    document.getElementById('editMenuId').value = menuId;
                    document.getElementById('editName').value = name;
                    document.getElementById('editPrice').value = price;
                    document.getElementById('editCategory').value = category;
                    document.getElementById('editIsAvailable').checked = isAvailable;
                    
                    // Show current image if exists
                    const imageContainer = document.getElementById('currentImageContainer');
                    imageContainer.innerHTML = '';
                    
                    if (imageUrl && imageUrl !== 'null') {
                        const img = document.createElement('img');
                        img.src = '${pageContext.request.contextPath}/' + imageUrl;
                        img.style.maxWidth = '150px';
                        img.style.maxHeight = '150px';
                        img.style.margin = '10px 0';
                        imageContainer.appendChild(img);
                    } else {
                        imageContainer.innerHTML = '<p>No current image</p>';
                    }
                    
                    // Show the modal
                    modal.style.display = 'block';
                });
            });
            
            // Add validation for edit form
            document.getElementById('editForm').addEventListener('submit', function(e) {
                const priceInput = this.querySelector('input[name="price"]');
                
                if (isNaN(parseFloat(priceInput.value)) || parseFloat(priceInput.value) <= 0) {
                    alert('Price must be a number greater than 0');
                    e.preventDefault();
                    return false;
                }
                
                return true;
            });
        </script>
    </body>
</html>