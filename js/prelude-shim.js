(function(global) {
  var prelude = global.prelude || {};
  function ensure(name, fallback) {
    if (prelude[name] == null && typeof fallback === 'function') {
      prelude[name] = fallback;
    }
  }
  ensure('flatten', function(list) {
    var result = [];
    (function walk(value) {
      var i;
      if (Array.isArray(value)) {
        for (i = 0; i < value.length; i++) {
          walk(value[i]);
        }
      } else if (value != null) {
        result.push(value);
      }
    })(list);
    return result;
  });
  ensure('join', function(sep, list) {
    if (!Array.isArray(list)) {
      return '';
    }
    return list.join(sep);
  });
  ensure('listsToObj', function(list) {
    var obj = {}, i, pair;
    if (!Array.isArray(list)) {
      return obj;
    }
    for (i = 0; i < list.length; i++) {
      pair = list[i];
      if (Array.isArray(pair) && pair.length) {
        obj[pair[0]] = pair[1];
      }
    }
    return obj;
  });
  ensure('take', function(count, list) {
    if (!Array.isArray(list)) {
      return [];
    }
    return list.slice(0, Math.max(0, count));
  });
  ensure('isType', function(type, value) {
    return Object.prototype.toString.call(value).slice(8, -1) === type;
  });
  ensure('unique', function(list) {
    var seen = new Set();
    if (!Array.isArray(list)) {
      return [];
    }
    return list.filter(function(item) {
      if (seen.has(item)) {
        return false;
      }
      seen.add(item);
      return true;
    });
  });
  ensure('sort', function(list) {
    if (!Array.isArray(list)) {
      return [];
    }
    return list.slice().sort();
  });
  if (prelude.Str == null) {
    prelude.Str = {};
  }
  global.prelude = prelude;
})(typeof window !== 'undefined' ? window : this);
