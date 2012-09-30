class Swatch {
  private {
    var join  = require('path').join;
    var watch = require('watch');
  }

  function initialize(from, to) {
    this.from = from;
    this.to   = to;
  }

  function plugin(options) {
    var opts = options;
    this.plugins.push(opts);
  }

  function processFile(file) {
    foreach (var p in this.plugins) {
      if (p.match(file)) this.handle(file, p);
    }
  }

  function tranposeFilename(file, plugin) {
    var ret = file.replace(/\.(\w+)/, '.' + plugin.toExt);
    return ret.replace(this.from, this.to);
  }

  function handle(file, plugin, cb) {
    var to = this.tranposeFilename(file, plugin);
    fs.readFile(file, #(err, data) {
      if (err) return cb(err);
      var out = plugin.compile(data);
      fs.writeFile(to, out);
    });
  }

}
