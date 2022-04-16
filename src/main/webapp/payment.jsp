<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Оплата</title>
</head>
<body>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
<script>
    let context = "http://" + "<%=request.getServerName()%>"
        + ":" + "<%=request.getServerPort()%>"
        + "/" + "<%=request.getServletContext().getContextPath()%>";
    function validate() {
        const username = $('#username').val();
        const phone = $('#phone').val();
        const email = $('#email').val();
        let alertMessage = "";
        if (username === "") {
            alertMessage = "Нужно заполнить имя\n";
        }
        if (phone === "") {
            alertMessage += "Нужно указать телефон\n";
        }
        if (email === "") {
            alertMessage += "Нужно указать электронную почту";
        }
        if (alertMessage !== "") {
            alert(alertMessage);
            return false;
        }
        return true;
    }
    function preparePage() {
        window.onload = function () {
            let params = new URLSearchParams(location.search);
            let row = params.get("row");
            let column = params.get("column");
            let p = document.createElement("p");
            p.innerText = "Вы выбрали ряд " + row + " место " + column + ", Сумма : 500 рублей.";
            document.getElementById("mainHeader").append(p);
            let mainForm = document.getElementById("mainForm");
            mainForm.action = context + "/pay";
            let hiddenInputRow = document.getElementById("row");
            hiddenInputRow.value = row;
            let hiddenInputCol = document.getElementById("column");
            hiddenInputCol.value = column;
        }
    }
    preparePage();
</script>
<div class="container">
    <div class="row pt-3">
        <h3 id="mainHeader">
        </h3>
    </div>
    <div class="row">
        <form id="mainForm" method="post" onsubmit="return validate()">
            <div class="form-group">
                <label for="username">ФИО</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="ФИО">
            </div>
            <div class="form-group">
                <label for="phone">Номер телефона</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="Номер телефона">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="text" class="form-control" id="email" name="email" placeholder="Email">
            </div>
            <div class="form-group">
                <input type="hidden" class="form-control" id="row" name="row">
            </div>
            <div class="form-group">
                <input type="hidden" class="form-control" id="column" name="column">
            </div>
            <button type="submit" class="btn btn-success">Оплатить</button>
        </form>
    </div>
</div>
</body>
</html>