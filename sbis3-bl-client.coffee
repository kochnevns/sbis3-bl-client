request = require 'request'

class SBIS3RPCClient
  constructor: (host) ->
      @host = host
      @headers =  'Content-type': 'application/json; charset=UTF-8'

  callMethod: (method, path = '', params) ->
      reqBody =
        'jsonrpc': '2.0'
        'protocol': 3
        'method': method
        'params': if params then params else {}
        'id': 1

      path = if path then path + '/service/' else path
      reqOptions =
        method : 'POST'
        url : @host + path
        headers : @headers
        body: JSON.stringify reqBody

      new Promise (resolve, reject) ->
        serviceRequest = request reqOptions, (err, res, body) ->
          resolve JSON.parse(arguments[1].body).result
          

  auth: (login = 'admin', password = 'admin') ->
    result = @callMethod 'САП.АутентифицироватьРасш', '/auth', login : login, password : password
    result.then (res) =>
      sessionId = res.d[0][1]
      @headers['X-SBISSessionID'] = sessionId


module.exports = SBIS3RPCClient
