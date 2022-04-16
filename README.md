### Project Cinema service

#### Description

This is an application for ordering cinema tickets.
The user can see the occupied places,
choose and book free.<br>
Это приложение для заказа билетов в кинотеатре.
Пользователь может видеть занятые места, 
выбрать и забронировать свободные.


#### Обзор

Главная страница.

![ScreenShot](images/main.png)

Страница бронирования.

![ScreenShot](images/order.png)

Ошибка создания учетной записи.

![ScreenShot](images/acc_error.png)

Ошибка бронированиня билета.

![ScreenShot](images/ticket_error.png)

#### Настройка и сборка

У приложения есть один файл конфигурации: /src/main/resources/db.properties,

в котором необходимо указать настройки соединения с сервером баз данных.

Сборка осуществляется командой: mvn package.

После сборки приложение нужно развернуть в контейнере сервлетов и настроить сервер баз данных.