#kek
sbis3bl = require './sbis3-bl-client.js'
c = new sbis3bl 'http://kochnevns.develop.sbis.ru'

c.auth().then ->
  console.log 'being auth...'
.then ->
  c.callMethod 'Платформа.Версия', '/admin'
.then (res) ->
  console.log res
