INSERT INTO Menu(Descripcion, Accion, Controlador, imagen) VALUES('Panel Central', 'Dashboard', 'Home', 'Home.png');
INSERT INTO Menu(Descripcion, Accion, Controlador, imagen) VALUES('Mi cuenta', 'Index', 'Perfil', 'MiCuenta.png');
INSERT INTO Menu(Descripcion, Accion, Controlador, imagen) VALUES('Mi red', 'Index', 'Red', 'MiRed.png');
INSERT INTO Menu(Descripcion, Accion, Controlador, imagen) VALUES('Transacciones', 'Index', 'Transaccion', 'Transaccion.png');
INSERT INTO Menu(Descripcion, Accion, Controlador, imagen) VALUES('Compra', 'Index', 'Compra', 'Compra.png');
INSERT INTO Menu(Descripcion, Accion, Controlador, imagen) VALUES('Noticias', 'Index', 'Noticias', 'Noticias.png');

INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Panel Central'), 1, 'Panel Central');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Mi cuenta'), 1, 'Mi Cuenta');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Mi red'), 1, 'Mi Red');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Transacciones'), 1, 'Transacciones');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Compra'), 1, 'Compra');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Noticias'), 1, 'Noticias');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Panel Central'), 2, 'Central Panel');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Mi cuenta'), 2, 'My Account');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Mi red'), 2, 'My Network');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Transacciones'), 2, 'Transactions');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Compra'), 2, 'Buys');
INSERT INTO MenuTraduccion(Menu, Idioma, Descripcion) VALUES((SELECT Menu FROM Menu WHERE Descripcion = 'Noticias'), 2, 'News');

INSERT INTO IdiomaTraduccion(Idioma, IdiomaTraduccion, Descripcion) VALUES(1, 1, 'Español');
INSERT INTO IdiomaTraduccion(Idioma, IdiomaTraduccion, Descripcion) VALUES(2, 1, 'Ingles');
INSERT INTO IdiomaTraduccion(Idioma, IdiomaTraduccion, Descripcion) VALUES(1, 2, 'Spanish');
INSERT INTO IdiomaTraduccion(Idioma, IdiomaTraduccion, Descripcion) VALUES(2, 2, 'English');

INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(1,1, 'Registro al Portal', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(2,1, 'Zafiro', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(3,1, 'Cuarzo', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(4,1, 'Rubi', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(5,1, 'Esmeralda', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(6,1, 'Bronce', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(7,1, 'Plata', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(8,1, 'Oro', 'ETH', '%', 'Alertas', 'Dias', 'Maximo Día');

INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(1,2, 'Registration to Portal', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(2,2, 'Sapphire', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(3,2, 'Quartz', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(4,2, 'Ruby', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(5,2, 'Emerald', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(6,2, 'Bronze', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(7,2, 'Silver', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');
INSERT INTO ProductoTraduccion(Producto, Idioma, Descripcion, Mensaje_Monto, Mensaje_Binario, Mensaje_Alerta, Mensaje_Dia, Mensaje_OutMax)
VALUES(8,2, 'Gold', 'ETH', '%', 'Alerts', 'Days', 'Maximum day');

INSERT INTO Idioma(Descripcion, Imagen) VALUES('Ingles', 'UnitedStates.png');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Login', '{
	"lblUsuario": "Usuario",
	"lblPassword": "Contraseña",
	"btnLogin": "Ingreso",
	"btnCancelar": "Cancelar",
	"lblNoRegistro": "¿Aún no te registras?",
	"lblOlvidaPass": "¿Olvidaste tu contraseña?",
	"linkRegistro": "Crear cuenta",
	"linkRecuperar": "Recuperar contraseña"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Login', '{
	"lblUsuario": "Username",
	"lblPassword": "Password",
	"btnLogin": "Login",
	"btnCancelar": "Cancel",
	"lblNoRegistro": "Not yet registered?",
	"lblOlvidaPass": "Forgot your password?",
	"linkRegistro": "Create account",
	"linkRecuperar": "Recover password"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Registro', '{
	"lblPatrocinador": "Patrocinador",
	"lblUsuario": "Usuario",
	"lblNombres": "Nombres",
	"lblApellidos": "Apellidos",
	"lblEmail": "Correo electrónico",
	"lblCartera": "Cartera criptomoneda",
	"lblPassword": "Contraseña",
	"lblConfirmar": "Confirmar",
	"btnRegistrar": "Registrarse",
	"btnCancelar": "Cancelar",
	"vldPatrocinadorMinLength": "Mínimo 3 caracteres",
	"vldUsuarioMinExcludeTo": "El usuario del patrocinador no debe ser igual al usuario a registrar",
	"vldUsuarioMinLength": "Mínimo 3 caracteres",
	"vldNombresMinLength": "Mínimo 2 caracteres",
	"vldApellidosMinLength": "Mínimo 2 caracteres",
	"vldEmailFormat": "Formato incorrecto",
	"vldPasswordMinLength": "Mínimo 8 caracteres",
	"vldConfirmarExcludeTo": "Las contraseñas no son iguales",
	"vldConfirmarMinLength": "Mínimo 8 caracteres"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Registro', '{
	"lblPatrocinador": "Sponsor",
	"lblUsuario": "Username",
	"lblNombres": "Name",
	"lblApellidos": "Last name",
	"lblEmail": "Email",
	"lblCartera": "Cryptocurrency wallet",
	"lblPassword": "Password",
	"lblConfirmar": "Confirm",
	"btnRegistrar": "Register",
	"btnCancelar": "Cancela",
	"vldPatrocinadorMinLength": "At least 3 characters",
	"vldUsuarioMinExcludeTo": "The sponsor user should not be the same as the user to register",
	"vldUsuarioMinLength": "At least 3 characters",
	"vldNombresMinLength": "At least 2 characters",
	"vldApellidosMinLength": "At least 2 characters",
	"vldEmailFormat": "Invalid format",
	"vldPasswordMinLength": "At least 8 characters",
	"vldConfirmarExcludeTo": "Passwords are not the same",
	"vldConfirmarMinLength": "At least 8 characters"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'PrimerCompra', '{
	"lblPrincipal": "Para poder continuar con tu proceso de registro debes realizar la compra de por lo menos uno de nuestros paquetes",
	"btnComprar": "Comprar",
	"btnCancelar": "Cancelar"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'PrimerCompra', '{
	"lblPrincipal": "In order to continue with your registration process you must make the purchase of at least one of our packages",
	"btnComprar": "Buy",
	"btnCancelar": "Cancel"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'ConfirmaCompra', '{
	"lblTitulo": "Tu información ha sido registrada con exito.",
	"lblSubtitulo": "Para continuar debes realizar tú pago en la siguiente dirección: ",
	"lblTotal": "Total a pagar: ",
	"lblTiempo": "Tiempo aproximado: ",
	"lblDireccion": "Enviar a la dirección: "
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'ConfirmaCompra', '{
	"lblTitulo": "Your information has been successfully registered.",
	"lblSubtitulo": "To continue you must make your payment at the following address: ",
	"lblTotal": "Total to pay: ",
	"lblTiempo": "Approximate time: ",
	"lblDireccion": "Send to the address: "
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Dashboard', '{
	"lblBienvenida": "Bienvenido",
	"lblTitulo": "esta es tu oficina virtual",
	"lblEstado": "Actualmente te encuentras",
	"lblCuerpo1": "Haz crecer tus ganancias incrementando la cantidad de personas que forman parte de tu equipo de trabajo, comparte este link",
	"lblCuerpo2": "para que tus conocidos y amigos formen parte de tu arbol.",
	"lblIzquierda": "Izquierda",
	"lblDerecha": "Derecha",
	"lblTotal": "Total",
	"lblPaquete": "Paquete actual",
	"btnRefrescar": "Refrescar",
	"btnCerrar": "Cerrar"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Dashboard', '{
	"lblBienvenida": "Welcome",
	"lblTitulo": "this is your virtual office",
	"lblEstado": "You are currently",
	"lblCuerpo1": "Grow your profits by increasing the number of people who are part of your team, share this link",
	"lblCuerpo2": "so that your acquaintances and friends are part of your tree.",
	"lblIzquierda": "Left",
	"lblDerecha": "Rigth",
	"lblTotal": "Total",
	"lblPaquete": "Current package",
	"btnRefrescar": "Refresh",
	"btnCerrar": "Close"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Perfil', '{
	"btnRefrescar": "Refrescar",
	"btnCerrar": "Cerrar",
	"infLblGeneral": "Información registrada",
	"infLblPatrocinador": "Patrocinador: ",
	"infLblUsuario": "Usuario: ",
	"infLblNombre": "Nombre: ",
	"infLblApellido": "Apellido",
	"infLblEmail": "Email",
	"infLblCartera": "Cartera",
	"infLblEstado": "Estado",
	"chplblGeneral": "Cambiar contraseña",
	"chplblUsuario": "Usuario",
	"chplblPassword": "Contraseña",
	"chplblPassNew": "Contraseña",
	"chplblConfirm": "Confirmar",
	"chplblPassNewMinLength": "Mínimo 8 caracteres",
	"chplblConfirmExclude": "Las contraseñas no son iguales",
	"chplblConfirmMinLength": "Mínimo 8 caracteres",
	"chpbtnCambiar": "Cambiar",
	"chilblGeneral": "Cambiar información",
	"chilblUsuario": "Usuario",
	"chilblPassword": "Contraseña",
	"chilblNombres": "Nombres",
	"chilblApellidos": "Apellidos",
	"chilblEmail": "Correo electrónico",
	"chilblCartera": "Cartera criptomoneda",
	"chibtnCambiar": "Cambiar",
	"chilblNombresMinLength": "Mínimo 2 caracteres",
	"chilblApellidosMinLenght": "Mínimo 2 caracteres",
	"chilblEmailFormat": "Formato incorrecto",
	"pqalblGeneral": "Paquete actual"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Perfil', '{
	"btnRefrescar": "Refresh",
	"btnCerrar": "Close",
	"infLblGeneral": "Registered information",
	"infLblPatrocinador": "Sponsor: ",
	"infLblUsuario": "User: ",
	"infLblNombre": "Name: ",
	"infLblApellido": "Last name",
	"infLblEmail": "Email",
	"infLblCartera": "Wallet",
	"infLblEstado": "Status",
	"chplblGeneral": "Change password",
	"chplblUsuario": "User",
	"chplblPassword": "Password",
	"chplblPassNew": "Password",
	"chplblConfirm": "Confirm",
	"chplblPassNewMinLength": "At least 8 characters",
	"chplblConfirmExclude": "Passwords are not the same",
	"chplblConfirmMinLength": "At least 8 characters",
	"chpbtnCambiar": "Change",
	"chilblGeneral": "Change information",
	"chilblUsuario": "User",
	"chilblPassword": "Password",
	"chilblNombres": "Name",
	"chilblApellidos": "Last name",
	"chilblEmail": "Email",
	"chilblCartera": "Cryptocurrency wallet",
	"chibtnCambiar": "Change",
	"chilblNombresMinLength": "At least 2 characters",
	"chilblApellidosMinLenght": "At least 2 characters",
	"chilblEmailFormat": "Invalid format",
	"pqalblGeneral": "Current package"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Red', '{
	"lblIzquierda": "Izquierda",
	"lblDerecha": "Derecha",
	"btnRefrescar": "Refrescar",
	"btnCancelar": "Cancelar",
	"lblPorcentaje": "Porcentajes de avance",
	"ventana": {
		"lblProductoActual": "Producto actual: ",
		"lblMontoAcumulado": "Monto acumulado: ",
		"lblMontoDiario": "Monto diario: ",
		"lblMontoDirecto": "Monto directo: "
	}
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Red', '{
	"lblIzquierda": "Left",
	"lblDerecha": "Rigth",
	"btnRefrescar": "Refresh",
	"btnCancelar": "Cancel",
	"lblPorcentaje": "Advance percentages",
	"ventana": {
		"lblProductoActual": "Current product: ",
		"lblMontoAcumulado": "Amount Accumulated: ",
		"lblMontoDiario": "Daily amount: ",
		"lblMontoDirecto": "Direct amount: "
	}
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Compras', '{
	"btnRefrescar": "Refrescar",
	"btnCancelar": "Cancelar",
	"lblMensaje": "Tome en cuenta que puede hacer una actualización de su paquete, únicamente a montos mayores del actualmente adquirido para poder aumentar sus ganancias",
	"lblError": "No puedes comprar paquetes con una cantidad menor o igual a la del paquete actual",
	"lblConfirmaCompra": "¿Se encuentra realmente seguro de comprar este paquete?",
	"btnCompra": "Comprar",
	"BtnCancelaCompra": "Cancelar",
	"btnCerrar": "Cerrar",
	"Confirmacion": {
		"lblTotal": "Total a pagar: ",
		"lblDireccion": "Enviar a la dirección: ",
		"lblTiempo": "Tiempo aproximado: "
	}
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Compras', '{
	"btnRefrescar": "Refresh",
	"btnCancelar": "Cancel",
	"lblMensaje": "Take into account that you can upgrade your package, only to larger amounts than the one currently purchased in order to increase your profits",
	"lblError": "You can not buy packages with less than or equal to the current package",
	"lblConfirmaCompra": "Are you really sure of buying this package?",
	"btnCompra": "Buy",
	"BtnCancelaCompra": "Cancel",
	"btnCerrar": "Close",
	"Confirmacion": {
		"lblTotal": "Total to pay: ",
		"lblDireccion": "Send to address: ",
		"lblTiempo": "Approximate time: "
	}
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Transaccion', '{
	"btnRefrescar": "Refrescar",
	"btnCancelar": "Cancelar",
	"lblMensaje": "Tome en cuenta que puede hacer una actualización de su paquete, únicamente a montos mayores del actualmente adquirido para poder aumentar sus ganancias",
	"btnExportPDF": "Exportar a PDF",
	"btnExportXLS": "Exportar a EXCEL",
	"Columnas": {
		"Transaccion": "Transaccion",
		"Paquete": "Paquete",
		"Estado": "Estado",
		"Monto": "Monto",
		"FTransaccion": "F. Transaccion",
		"FVencimiento": "F. Vencimiento"
	},
	"Confirmacion": {
		"lblTotal": "Total a pagar: ",
		"lblDireccion": "Enviar a la dirección: ",
		"lblTiempo": "Tiempo aproximado: ",
		"btnCerrar": "Cerrar"
	}
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Transaccion', '{
	"btnRefrescar": "Refresh",
	"btnCancelar": "Cancel",
	"lblMensaje": "Take into account that you can upgrade your package, only to larger amounts than the one currently purchased in order to increase your profits",
	"btnExportPDF": "Export to PDF",
	"btnExportXLS": "Export to EXCEL",
	"Columnas": {
		"Transaccion": "Transaction",
		"Paquete": "Package",
		"Estado": "Status",
		"Monto": "Amount",
		"FTransaccion": "Transaction D.",
		"FVencimiento": "Expirate D."
	},
	"Confirmacion": {
		"lblTotal": "Total to pay: ",
		"lblDireccion": "Send to address: ",
		"lblTiempo": "Approximate time: ",
		"btnCerrar": "Close"
	}
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(1, 'Noticias', '{
	"btnRefrescar": "Refrescar",
	"btnCancelar": "Cancelar",
	"lblTitulo": "Noticias"
}');

INSERT INTO Vista(Idioma, Nombre, ObjetoJson)
VALUES(2, 'Noticias', '{
	"btnRefrescar": "Refresh",
	"btnCancelar": "Cancel",
	"lblTitulo": "News"
}');