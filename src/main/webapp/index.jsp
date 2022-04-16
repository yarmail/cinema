<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Бронирование мест</title>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>

    <%
        int rowNum = Integer.parseInt(request.getServletContext().getInitParameter("rowNum"));
        int colNum = Integer.parseInt(request.getServletContext().getInitParameter("colNum"));
    %>

    <script>
        let rowNum = <%=rowNum%>;
        let colNum = <%=colNum%>;
        let context = "http://" + "<%=request.getServerName()%>"
            + ":" + "<%=request.getServerPort()%>"
            + "/" + "<%=request.getServletContext().getContextPath()%>";
        function validate() {
            let radioId = "";
            let radioButton;
            for (let row = 1; row <= rowNum; row++) {
                for (let column = 1; column <= colNum; column++) {
                    radioId = "radior" + row + "c" + column;
                    radioButton = document.getElementById(radioId);
                    if (radioButton !== null && radioButton.checked === true) {
                        let place = {};
                        place.row = row;
                        place.column = column;
                        return place;
                    }
                }
            }
            return null;
        }
        function goToPayment() {
            let place = validate();
            if (place !== null) {
                let row = place.row;
                let column = place.column;
                window.location.assign("payment.jsp" + "?row=" + row + "&column=" + column);
            } else {
                alert("Выберите место");
            }
        }
        function getTickets() {
            return $.ajax({
                type: 'GET',
                url: context + '/hall',
                dataType: 'json'
            })
        }
        function reDrawHall() {
            window.onload = getTickets().done(function (data) {
                let places = [];
                let usedPLaces = [];
                let usedCount = 0;
                let tdId;
                for (let row = 1; row <= rowNum; row++) {
                    for (let column = 1; column <= colNum; column++) {
                        tdId = "r" + row + "c" + column;
                        places.push(tdId);
                    }
                }
                for (let ticket of data) {
                    let row = ticket.row.toString();
                    let col = ticket.col.toString();
                    let tdId = "r" + row + "c" + col;
                    usedPLaces.push(tdId);
                }
                for (let i = 0; i < places.length; i++) {
                    let td = document.getElementById(places[i]);
                    while (td.firstChild) {
                        td.removeChild(td.firstChild);
                    }
                    if (usedPLaces.includes(places[i])) {
                        let span = document.createElement("span");
                        span.innerText = "Продано";
                        span.className = "badge badge-warning m-2";
                        td.appendChild(span);
                        usedCount++;
                    } else {
                        let span = document.createElement("span");
                        span.innerText = "Купить";
                        span.className = "badge badge-success m-2";
                        let input = document.createElement("input");
                        input.type = "radio";
                        input.id = "radio" + places[i];
                        input.name = "place";
                        td.append(span);
                        td.append(input);
                    }
                }
                let payButton = document.getElementById("payButton");
                payButton.disabled = usedCount === places.length;
            })
        }
        reDrawHall();
        setInterval(reDrawHall, 15000);
    </script>
</head>
<body>
<div class="container">
    <div class="row pt-3">
        <h4 id="mainHeader">
            Бронирование мест на сеанс
        </h4>
        <table class="table table-bordered">
            <thead class="thead-light">
            <tr>
                <th style="width: 120px;">Ряд / Место</th>
                <c:forEach var = "column" begin = "1" end = "<%=colNum%>">
                    <th><c:out value = "${column}"/></th>
                </c:forEach>
            </tr>
            </thead>
            <tbody>
            <c:forEach var = "row" begin = "1" end = "<%=rowNum%>">
                <tr>
                    <th class="table-active"><c:out value = "${row}"/></th>
                    <c:forEach var = "column" begin = "1" end = "<%=colNum%>">
                        <td id='r<c:out value = "${row}"/>c<c:out value = "${column}"/>'>
                            <span class="badge badge-success">Купить</span>
                            <input type="radio" name="place" id='radior<c:out value = "${row}"/>c<c:out value = "${column}"/>'>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="row float-right">
        <button type="button" class="btn btn-success" id="payButton" onclick="goToPayment()">Оплатить</button>
    </div>
</div>
</body>
</html>