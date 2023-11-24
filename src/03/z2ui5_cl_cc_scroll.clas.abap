CLASS z2ui5_cl_cc_scroll DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_s_item,
        id       TYPE string,
        scrollto TYPE string,
      END OF ty_s_item.
    TYPES ty_t_item TYPE STANDARD TABLE OF ty_s_item WITH DEFAULT KEY ##NEEDED.

    METHODS constructor
      IMPORTING
        view TYPE REF TO z2ui5_cl_xml_view.

    METHODS control
      IMPORTING
        setupdate     TYPE clike OPTIONAL
        items         TYPE clike OPTIONAL
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_xml_view.

    METHODS load_cc
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_xml_view.

    CLASS-METHODS get_js
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
    DATA mo_view TYPE REF TO z2ui5_cl_xml_view.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_cc_scroll IMPLEMENTATION.


  METHOD constructor.

    me->mo_view = view.

  ENDMETHOD.


  METHOD control.

    result = mo_view.
    mo_view->_generic( name   = `Scroll`
              ns     = `z2ui5`
              t_prop = VALUE #(
                ( n = `setUpdate`   v = setupdate )
                ( n = `items`       v = items )
       ) ).

  ENDMETHOD.


  METHOD get_js.

    result = `debugger; jQuery.sap.declare("z2ui5.Scroll");` && |\n|  &&
             `sap.ui.require([` && |\n|  &&
             `  "sap/ui/core/Control",` && |\n|  &&
             `], (Control) => {` && |\n|  &&
             `  "use strict";` && |\n|  &&
             |\n|  &&
             `  return Control.extend("z2ui5.Scroll", {` && |\n|  &&
             `      metadata: {` && |\n|  &&
             `          properties: {` && |\n|  &&
             `              setUpdate: { type: "boolean" , defaultValue: true},` && |\n|  &&
             `              items: { type: "Array" },` && |\n|  &&
             `          }` && |\n|  &&
             `      },` && |\n|  &&
             |\n|  &&
             `      setBackend() {  ` && |\n| &&
               `   if (this.mProperties.items){ this.mProperties.items.forEach(item => {` && |\n| &&
                           `                        try {` && |\n| &&
                           `                            item.SCROLLTO = sap.z2ui5.oView.byId(item.ID).getScrollDelegate().getScrollTop();` && |\n| &&
                           `                        } catch (e) {` && |\n| &&
                           `                            try {` && |\n| &&
                           `                                var ele = '#' + sap.z2ui5.oView.byId(item.ID).getId() + '-inner';` && |\n| &&
                           `                                item.SCROLLTO = $(ele).scrollTop();` && |\n| &&
                           `                            } catch (e) { }` && |\n| &&
                           `                        }` && |\n| &&
                           `                    });` && |\n| &&
             `  } },` && |\n|  &&
             `      init() {    sap.z2ui5.onBeforeRoundtrip.push( this.setBackend.bind(this) );   },` && |\n|  &&
             `      renderer(oRm, oControl) {` && |\n|  &&
             |\n|  &&
             `       ` && |\n|  &&
             `            if (!oControl.getProperty("setUpdate")){ return; }` && |\n|  &&
             |\n|  &&
             `            oControl.setProperty("setUpdate", false);` && |\n|  &&
             `          var items = oControl.getProperty("items");` && |\n|  &&
*            `           var resBinding = new sap.ui.model.ListBinding(sap.z2ui5.oView.getModel( ), "/EDIT/MT_SCROLL" );` && |\n|  &&
*            `           resBinding.attachChange( ( ) => { alert( "Model Change" ); } ); ` &&
             `          if(!items){return;};` && |\n|  &&
             |\n|  &&
             `            setTimeout( (oControl) => { ` && |\n|  &&
             `              var items = oControl.getProperty("items");  ` && |\n|  &&
             `              items.forEach(item => {` && |\n|  &&
             `                  try {` && |\n|  &&
             `                      sap.z2ui5.oView.byId(item.ID).scrollTo(item.SCROLLTO);` && |\n|  &&
             `                  } catch {` && |\n|  &&
             `                      try {` && |\n|  &&
             `                          var ele = '#' + sap.z2ui5.oView.byId(item.ID).getId() + '-inner';` && |\n|  &&
             `                          $(ele).scrollTop(item.SCROLLTO);` && |\n|  &&
             `                      } catch { setTimeout( function( item ) { sap.z2ui5.oView.byId(item.ID).scrollTo(item.SCROLLTO); } , 1 , item);}` && |\n|  &&
             `                  }` && |\n|  &&
             `              }      ` && |\n|  &&
             `              );` && |\n|  &&
             |\n|  &&
             `            } , 50 , oControl );` && |\n|  &&
             `      }` && |\n|  &&
             `  });` && |\n|  &&
             `});`.
  ENDMETHOD.


  METHOD load_cc.

    result = mo_view->_generic( ns = `html` name = `script` )->_cc_plain_xml( get_js( ) )->get_parent( ).

  ENDMETHOD.
ENDCLASS.
