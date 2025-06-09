CLASS z2ui5_cl_app_formatter_js DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS get
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_app_formatter_js IMPLEMENTATION.

  METHOD get.

    result =              `sap.ui.define([], function () {` && |\n|  &&
             `  "use strict";` && |\n|  &&
             `  return {` && |\n|  &&
             `    dynamicClass: function (...args) {` && |\n|  &&
             `      const classes = [];` && |\n|  &&
             `      args.forEach((val, i) => {` && |\n|  &&
             `        if (i % 2 === 0) {` && |\n|  &&
             `          if (val) {` && |\n|  &&
             `            if (args[i + 1]) {` && |\n|  &&
             `              classes.push(args[i + 1]);` && |\n|  &&
             `            }` && |\n|  &&
             `          }` && |\n|  &&
             `        }` && |\n|  &&
             `      });` && |\n|  &&
             `      return classes.join(" ");` && |\n|  &&
             `    },` && |\n|  &&
             `  };` && |\n|  &&
             `});` && |\n|  &&
             `` && |\n|  &&
              ``.

  ENDMETHOD.

ENDCLASS.
