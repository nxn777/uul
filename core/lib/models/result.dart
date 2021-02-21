import 'package:rest/rest.dart';

class UULResult<Success> extends Result<Success, UULResponse> {
  static void _checkValid(UULResult result) {
    if (result._success != null && result._failure != null) {
      throw Exception("Result is success and failure at the same time:\nSuccess:$result._success\nFailure:$result._failure");
    }
  }

  UULResult.success(Success s) : super.success(s);

  UULResult.failure(UULResponse response) : super.failure(response);

  void fold({void Function(Success) onSuccess, void Function(UULResponse) onFailure}) {
    _checkValid(this);
    if (_success != null) {
      onSuccess?.call(_success);
    }
    if (_failure != null) {
      onFailure?.call(_failure);
    }
  }
  //
  // UULResult<NewSuccess> then<NewSuccess>(UULResult<NewSuccess> Function(Success) nextAction) {
  //   _checkValid(this);
  //   if (_success != null) {
  //     return nextAction.call(_success);
  //   }
  //   if (_failure != null) {
  //     return UULResult.failure(_failure);
  //   }
  //   throw Exception("Result is null for success and failure at the same time:\nSuccess:$_success\nFailure:$_failure");
  // }

  UULResult<CombinedResult2<Success, NewSuccess>> combineWith<NewSuccess>(UULResult<NewSuccess> secondResult) {
    _checkValid(this);
    if (_success != null) {
      _checkValid(secondResult);
      if (secondResult._success != null) {
        return UULResult.success(CombinedResult2(_success, secondResult._success));
      }
      if (secondResult._failure != null) {
        return UULResult.failure(secondResult._failure);
      }
    }
    if (_failure != null) {
      return UULResult.failure(_failure);
    }
    throw Exception("Result is null for success and failure at the same time:\nSuccess:$_success\nFailure:$_failure");
  }
}

class CombinedResult2<T1, T2> {
  final T1 value1;
  final T2 value2;
  CombinedResult2(this.value1, this.value2);
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
