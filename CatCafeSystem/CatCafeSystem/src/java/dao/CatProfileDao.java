package dao;

/**
 *
 * @author sitif
 */
import model.CatProfile;
import java.sql.*;
import java.util.*;

public class CatProfileDao {

    private Connection conn;

    public CatProfileDao(Connection conn) {
        this.conn = conn;
    }

    public List<CatProfile> getAllCats() throws SQLException {
        List<CatProfile> cats = new ArrayList<>();
        String sql = "SELECT * FROM cat_profiles";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            CatProfile cat = new CatProfile();
            cat.setCatId(rs.getInt("cat_id"));
            cat.setName(rs.getString("name"));
            cat.setImage(rs.getString("image"));
            cat.setBreed(rs.getString("breed"));
            cat.setAge(rs.getInt("age"));
            cat.setGender(rs.getString("gender"));
            cat.setHealthStatus(rs.getString("health_status"));
            cats.add(cat);
        }
        return cats;
    }

    public CatProfile getCatById(int id) throws SQLException {
        String sql = "SELECT * FROM cat_profiles WHERE cat_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            CatProfile cat = new CatProfile();
            cat.setCatId(rs.getInt("cat_id"));
            cat.setName(rs.getString("name"));
            cat.setImage(rs.getString("image"));
            cat.setBreed(rs.getString("breed"));
            cat.setAge(rs.getInt("age"));
            cat.setGender(rs.getString("gender"));
            cat.setHealthStatus(rs.getString("health_status"));
            return cat;
        }
        return null;
    }

    public CatProfile getRandomCat() throws SQLException {
        String sql = "SELECT * FROM cat_profiles ORDER BY RAND() LIMIT 1";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            CatProfile cat = new CatProfile();
            cat.setCatId(rs.getInt("cat_id"));
            cat.setName(rs.getString("name"));
            cat.setImage(rs.getString("image"));
            cat.setBreed(rs.getString("breed"));
            cat.setAge(rs.getInt("age"));
            cat.setGender(rs.getString("gender"));
            cat.setHealthStatus(rs.getString("health_status"));
            return cat;
        }
        return null;
    }

    public void updateCatProfile(CatProfile cat) throws SQLException {
        String sql = "UPDATE cat_profiles SET name=?, image=?, breed=?, age=?, gender=?, health_status=? WHERE cat_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, cat.getName());
        ps.setString(2, cat.getImage());
        ps.setString(3, cat.getBreed());
        ps.setInt(4, cat.getAge());
        ps.setString(5, cat.getGender());
        ps.setString(6, cat.getHealthStatus());
        ps.setInt(7, cat.getCatId());
        ps.executeUpdate();
    }

}
