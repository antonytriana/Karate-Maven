Feature: Get Tests on Google Books API
Background:
* def urlBase = 'https://www.googleapis.com/books/v1'

Scenario: Obtener la lista de libros de Harry Potter y comprobar valor en el titulo
Given url urlBase + '/volumes?q=harry+potter'
When method GET
Then status 200
And match $..title contains 'Harry Potter y la piedra filosofal'
And match $..id contains '#notnull'

Scenario: Obtener el libro El coronel no tiene quien le escriba con año de publicacion 2006
Given url urlBase + '/volumes/_e6XuQAACAAJ'
When method GET
Then status 200
And match $..publishedDate contains '2006'

Scenario: Obtener un libro que no existe por el ID
Given url urlBase + '/volumes/_LettPDhwR0Ca'
When method GET
Then status 503
And match $..message contains 'Service temporarily unavailable.'

Scenario: Obtener listado de libros en menos de 700 ms
Given url urlBase + '/volumes?q=cuento+de+los+hermanos+grimm'
When method GET
Then status 200
And assert responseTime < 700

Scenario: Validar respuesta de un libro sea tipo JSON
Given url urlBase + '/volumes/_e6XuQAACAAJ'
When method GET
Then status 200
And match responseType == 'json'
And print 'Response is: ', response