sap.ui.define([], function() {
  "use strict";
  return {
    dynamicClass: function (...args) {
        const classes = [];
        
        args.forEach((val, indx) => {
            if (i % 2 === 0) {
                if(val) {
                    const className = args[indx + 1];
                    if (className) {
                        classes.push(className);
                    }
                }
            }
        });
        return classes.join(" ");
    }
  }
});