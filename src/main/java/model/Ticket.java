package model;

public class Ticket {
    private final int sessionId;
    private final int row;
    private final int col;
    private final int accountId;

    public Ticket(int sessionId, int row, int col, int accountId) {
        this.sessionId = sessionId;
        this.row = row;
        this.col = col;
        this.accountId = accountId;
    }

    public int getSessionId() {
        return sessionId;
    }

    public int getRow() {
        return row;
    }

    public int getCol() {
        return col;
    }

    public int getAccountId() {
        return accountId;
    }
}
/*
Notes
Выпущенный билет не является самостоятельным
а привязан к пользовательскому аккаунту
private final int accountId;
 */
