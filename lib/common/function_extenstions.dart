extension Also on Function {
  Function also(Function action) {
    return () {
      var result = this();
      action();
      return result;
    };
  }
}
