class Response<T> {
  int? status;
  String? message;
  T? data;

  Response(ResponseBuilder builder){
    status = builder._status;
    message = builder._message;
    data = builder._data;
  }

}

class ResponseBuilder<T> {
  int _status = 0;
  String _message = "";
  T? _data;

  ResponseBuilder status(int status){
    _status = status;
    return this;
  }

  ResponseBuilder message(String message){
    _message = message;
    return this;
  }

  ResponseBuilder data(T data){
    _data = data;
    return this;
  }

  Response build(){
    return Response(this);
  }

}
