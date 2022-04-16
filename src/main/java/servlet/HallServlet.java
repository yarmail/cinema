package servlet;

import model.Ticket;
import store.DbStore;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

public class HallServlet extends HttpServlet {
    private static final Gson GSON = new GsonBuilder().create();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Ticket> tickets = DbStore.getInstance().findAllTickets();
        resp.setContentType("application/json");
        OutputStream out = resp.getOutputStream();
        String json = GSON.toJson(tickets);
        out.write(json.getBytes());
        out.flush();
        out.close();
    }
}
