package servlet;

import model.Account;
import model.Ticket;
import store.DbStore;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class PayServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        int row = Integer.parseInt(req.getParameter("row"));
        int col = Integer.parseInt(req.getParameter("column"));
        Account account = new Account(username, email, phone);
        int accountId = DbStore.getInstance().findAccount(account);
        if (accountId == -1) {
            try {
                accountId = DbStore.getInstance().createAccount(account);
            } catch (SQLException e) {
                e.printStackTrace();
                resp.sendRedirect("account_error.html");
                return;
            }
        }
        Ticket ticket = new Ticket(1, row, col, accountId);
        try {
            DbStore.getInstance().createTicket(ticket);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("ticket_error.html");
            return;
        }
        resp.sendRedirect("sold.html");
    }
}