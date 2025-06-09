sap.ui.define([], function () {
  "use strict";
  return {
    dynamicClass: function (...args) {
      const classes = [];
      args.forEach((val, i) => {
        if (i % 2 === 0) {
          if (val) {
            if (args[i + 1]) {
              classes.push(args[i + 1]);
            }
          }
        }
      });
      return classes.join(" ");
    },
  };
});
