// See the following file if further items need to be added:
// https://github.com/material-components/material-components-web/blob/master/packages/material-components-web/index.ts

import autoInit from '@material/auto-init/index';
import * as base from '@material/base/index';
import * as checkbox from '@material/checkbox/index';
import * as dataTable from '@material/data-table/index';
import * as dialog from '@material/dialog/index';
import * as formField from '@material/form-field/index';
import * as iconButton from '@material/icon-button/index';
import * as list from '@material/list/index';
import * as menu from '@material/menu/index';
import * as menuSurface from '@material/menu-surface/index';
import * as ripple from '@material/ripple/index';
import * as select from '@material/select/index';
import * as textField from '@material/textfield/index';

autoInit.register('MDCCheckbox', checkbox.MDCCheckbox);
autoInit.register('MDCDataTable', dataTable.MDCDataTable);
autoInit.register('MDCDialog', dialog.MDCDialog);
autoInit.register('MDCFormField', formField.MDCFormField);
autoInit.register('MDCIconButtonToggle', iconButton.MDCIconButtonToggle);
autoInit.register('MDCList', list.MDCList);
autoInit.register('MDCMenu', menu.MDCMenu);
autoInit.register('MDCMenuSurface', menuSurface.MDCMenuSurface);
autoInit.register('MDCRipple', ripple.MDCRipple);
autoInit.register('MDCSelect', select.MDCSelect);
autoInit.register('MDCTextField', textField.MDCTextField);

window.mdc = {
  autoInit,
  base,
  checkbox,
  dataTable,
  dialog,
  formField,
  iconButton,
  list,
  menu,
  menuSurface,
  ripple,
  select,
  textField,
};
