package controller;

import dao.MenuDAO;
import model.Menu;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

public class StaffMenuServlet extends HttpServlet {

    // Define your absolute image path
    private static final String IMAGE_BASE_PATH = "D:\\System Analysis Design\\Project Assignment\\CatCafeSystem (2)\\CatCafeSystem\\web\\images";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Menu> menu = MenuDAO.getAllMenu();
            request.setAttribute("menu", menu);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading menu: " + e.getMessage());
            e.printStackTrace();
        }
        request.getRequestDispatcher("/ManageMenuStaff.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // First check if it's a multipart request (for add/update)
        if (ServletFileUpload.isMultipartContent(request)) {
            handleMultipartRequest(request, response);
        } else {
            handleSimpleRequest(request, response);
        }
    }

    private void handleMultipartRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
            String action = null;
            int menuId = 0;

            // First pass to get action and menuId (for update)
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    if ("action".equals(fieldName)) {
                        action = item.getString("UTF-8");
                    } else if ("menuId".equals(fieldName)) {
                        menuId = Integer.parseInt(item.getString("UTF-8"));
                    }
                }
            }

            if ("add".equals(action)) {
                handleAddMenu(items, response);
            } else if ("update".equals(action)) {
                handleUpdateMenu(items, menuId, response);
            } else {
                handleError(request, response, "Invalid action for multipart request", null);
            }

        } catch (Exception e) {
            handleError(request, response, "Error processing request: " + e.getMessage(), e);
        }
    }

    private void handleSimpleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(request, response);
        } else if ("toggleAvailability".equals(action)) {
            handleToggleAvailability(request, response);
        } else {
            handleError(request, response, "Invalid action", null);
        }
    }

    private void handleAddMenu(List<FileItem> items, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        Menu menu = new Menu();
        String imagePath = null;

        for (FileItem item : items) {
            if (item.isFormField()) {
                processFormField(item, menu);
            } else {
                imagePath = processUploadedFile(item);
                if (imagePath != null) {
                    menu.setImageUrl(imagePath);
                }
            }
        }

        MenuDAO.addMenu(menu);
        response.sendRedirect("StaffMenuServlet");
    }

    private void handleUpdateMenu(List<FileItem> items, int menuId, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        Menu menu = new Menu();
        menu.setMenuID(menuId);
        String imagePath = null;

        for (FileItem item : items) {
            if (item.isFormField()) {
                processFormField(item, menu);
            } else {
                // Only process if new file was uploaded
                if (item.getSize() > 0) {
                    imagePath = processUploadedFile(item);
                    if (imagePath != null) {
                        menu.setImageUrl(imagePath);
                    }
                }
            }
        }

        // Keep existing image if no new one was uploaded
        if (menu.getImageUrl() == null) {
            menu.setImageUrl(MenuDAO.getImageUrl(menuId));
        }

        MenuDAO.updateMenu(menu);
        response.sendRedirect("StaffMenuServlet");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            String imageUrl = MenuDAO.getImageUrl(menuId);

            // Delete from database first
            MenuDAO.deleteMenu(menuId);

            // Delete image file if exists
            if (imageUrl != null && !imageUrl.isEmpty()) {
                String imagePath = IMAGE_BASE_PATH + imageUrl.replace("images/", "");
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    if (!imageFile.delete()) {
                        System.err.println("Warning: Could not delete image file: " + imagePath);
                    }
                }
            }

            response.sendRedirect("StaffMenuServlet");
        } catch (Exception e) {
            handleError(request, response, "Error deleting menu: " + e.getMessage(), e);
        }
    }

    private void handleToggleAvailability(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            MenuDAO.toggleMenuAvailability(menuId);
            response.sendRedirect("StaffMenuServlet");
        } catch (Exception e) {
            handleError(request, response, "Error toggling availability: " + e.getMessage(), e);
        }
    }

    private String processUploadedFile(FileItem item) throws Exception {
        if (item.getName() == null || item.getName().isEmpty()) {
            return null;
        }

        String originalName = new File(item.getName()).getName();
        String extension = originalName.substring(originalName.lastIndexOf('.')).toLowerCase();
        if (!extension.matches("\\.(jpg|jpeg|png|gif)$")) {
            throw new Exception("Only JPG, JPEG, PNG, or GIF images are allowed");
        }

        File dir = new File(IMAGE_BASE_PATH);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String filePath = IMAGE_BASE_PATH + originalName;

//        if (new File(filePath).exists()) {
//            throw new Exception("A file with this name already exists. Please rename your file before uploading.");
//        }
        item.write(new File(filePath));

        return "images/" + originalName;
    }

    private void processFormField(FileItem item, Menu menu) throws Exception {
        String fieldName = item.getFieldName();
        String value = item.getString("UTF-8");

        switch (fieldName) {
            case "name":
                menu.setName(value);
                break;
            case "price":
                menu.setPrice(Double.parseDouble(value));
                break;
            case "category":
                menu.setCategory(value);
                break;
            case "isAvailable":
                menu.setIsAvailable("on".equals(value) || "true".equals(value));
                break;
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
            String message, Exception e) throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("error", message);
        request.getRequestDispatcher("/ManageMenuStaff.jsp").forward(request, response);
    }
}
