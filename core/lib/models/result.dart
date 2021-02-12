import 'package:rest/rest.dart';

class UULResult<Success> extends Result<Success, UULResponse> {
  UULResult.success(Success s) : super.success(s);

  UULResult.failure(UULResponse response) : super.failure(response);

  void fold({void Function(Success) onSuccess, void Function(UULResponse) onFailure}) {
    if (_success != null && _failure != null) {
      throw Exception("Result is success and failure at the same time:\nSuccess:$_success\nFailure:$_failure");
    }
    if (_success != null) {
      onSuccess?.call(_success);
    }
    if (_failure != null) {
      onFailure?.call(_failure);
    }
  }
}

class Result<Success, Failure> {
  Success _success;
  Failure _failure;

  Result._({success, failure}) {
    this._success = success;
    this._failure = failure;
  }

  Result.success(Success s) : this._(success: s);
  Result.failure(Failure f) : this._(failure: f);

  Result(Success Function() catching) {
    try {
      _success = catching();
    } catch (e) {
      _failure = e;
    }
  }

  map<NewSuccess>(NewSuccess Function(Success) transform) {
    if (_success != null) {
      return new Result.success(transform(_success));
    } else {
      return new Result.failure(_failure);
    }
  }

  flatMap<NewSuccess>(Result<NewSuccess, Failure> Function(Success) transform) {
    if (_success != null) {
      return Result.success(transform(_success));
    } else {
      return Result.failure(_failure);
    }
  }

  mapError<NewFailure>(NewFailure Function(Failure) transform) {
    if (_failure != null) {
      return new Result.failure(transform(_failure));
    } else {
      return new Result.success(_success);
    }
  }

  flatMapError<NewFailure>(Result<Success, NewFailure> Function(Failure) transform) {
    if (_failure != null) {
      return Result.failure(transform(_failure));
    } else {
      return Result.success(_success);
    }
  }

  Success get() {
    if (_success != null) {
      return _success;
    } else {
      throw _failure;
    }
  }

  Success getOrNull() {
    if (_success != null) {
      return _success;
    } else {
      return null;
    }
  }
}
