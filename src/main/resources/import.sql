//Roles y usuario admin

INSERT INTO roles (ROL) VALUES ('ROLE_ADMIN');
INSERT INTO roles (ROL) VALUES ('ROLE_SUPER');
INSERT INTO roles (ROL) VALUES ('ROLE_SOLS');
INSERT INTO roles (ROL) VALUES ('ROLE_APRB');
INSERT INTO roles (ROL) VALUES ('ROLE_AUT');
INSERT INTO roles (ROL) VALUES ('ROLE_ATN');
INSERT INTO roles (ROL) VALUES ('ROLE_PROC');
INSERT INTO roles (ROL) VALUES ('ROLE_INV');
INSERT INTO roles (ROL) VALUES ('ROLE_CAMBIO_CONTRASENA');
INSERT INTO usuarios_sistema (NOMBRE_USUARIO, CUENTA_SINEXPIRAR, CUENTA_SINBLOQUEAR, CAMBIAR_CONTRASENA_ALLOGIN, DESCRIPCION, FECHA_REGISTRO, USUARIO_REGISTRO, CREDENCIAL_SINEXPIRAR, CORREO_ELECTRONICO, HABILITADO, FECHA_ULTACC, FECHA_ULTMODCRED, FECHA_ULTMOD, USUARIO_ULTMOD, CONTRASENA) VALUES ('admin', b'1', b'1', b'0', 'Administrador del Sistema', '2018-03-08 00:00:00', 'admin', b'1', 'waviles@icsnicaragua.org', b'1', '2018-03-08 00:00:00', '2018-03-08 00:00:00', '2018-03-08 00:00:00', 'admin', '6c36dc262b0e44be5811c2296669fc65643aec9dcaa4a76501e0a9508b633fd01ee59a207f8c6d68');
INSERT INTO usuarios_roles (ROL, NOMBRE_USUARIO, IDENTIFICADOR_EQUIPO, ESTADO, PASIVO, FECHA_REGISTRO, USUARIO_REGISTRO) VALUES ('ROLE_ADMIN', 'admin', 'admin', '2', '0', '2018-03-08 00:00:00', 'admin');
INSERT INTO usuarios_roles (ROL, NOMBRE_USUARIO, IDENTIFICADOR_EQUIPO, ESTADO, PASIVO, FECHA_REGISTRO, USUARIO_REGISTRO) VALUES ('ROLE_SUPER', 'admin', 'admin', '2', '0', '2018-03-08 00:00:00', 'admin');
INSERT INTO usuarios_roles (ROL, NOMBRE_USUARIO, IDENTIFICADOR_EQUIPO, ESTADO, PASIVO, FECHA_REGISTRO, USUARIO_REGISTRO) VALUES ('ROLE_CAMBIO_CONTRASENA', 'admin', 'admin', '2', '0', '2018-03-08 00:00:00', 'admin');
INSERT INTO usuarios_roles (ROL, NOMBRE_USUARIO, IDENTIFICADOR_EQUIPO, ESTADO, PASIVO, FECHA_REGISTRO, USUARIO_REGISTRO) VALUES ('ROLE_SOLS', 'admin', 'admin', '2', '0', '2018-03-08 00:00:00', 'admin');
INSERT INTO usuarios_roles (ROL, NOMBRE_USUARIO, IDENTIFICADOR_EQUIPO, ESTADO, PASIVO, FECHA_REGISTRO, USUARIO_REGISTRO) VALUES ('ROLE_APRB', 'admin', 'admin', '2', '0', '2018-03-08 00:00:00', 'admin');
INSERT INTO usuarios_roles (ROL, NOMBRE_USUARIO, IDENTIFICADOR_EQUIPO, ESTADO, PASIVO, FECHA_REGISTRO, USUARIO_REGISTRO) VALUES ('ROLE_AUT', 'admin', 'admin', '2', '0', '2018-03-08 00:00:00', 'admin');

/*Plantilla*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'heading', 'Sistema de Control de Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'title', 'SCS','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'footer', '2018 Instituto de Ciencias Sostenibles','0','0',0);

/*login page*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login', 'Ingresar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.accountExpired', 'Cuenta de usuario ha expirado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.accountLocked', 'Cuenta de usuario está bloqueada!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.accountNotLocked', 'Cuenta de usuario está desbloqueada!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.badCredentials', 'Nombre de usuario o contraseña incorrectos!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.credentialsExpired', 'Credenciales de usuario han expirado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.maxSessionsOut', 'Tiene una sesión activa! No puede crear otra!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.message', 'Por favor ingresar su nombre de usuario y contraseña','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.username', 'Nombre de usuario','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.password', 'Contraseña','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.forgot.password', 'Olvidó contraseña?','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.userEnabled', 'Usuario esta activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'login.userDisabled', 'Usuario esta inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ask.chgpass', 'Exigir cambio de contraseña','0','0',0);

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'seconds', 'segundos','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'session.expiring', 'Su sesión está a punto de expirar!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'session.expiring.confirm', 'Quiere continuar con su sesión?','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'session.expiring.time', 'Su sesión se cerrará en','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'session.keep', 'Mantener sesión','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'not', 'Notificación','0','0',0);

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'resetPassword', 'Enviar nueva contraseña por correo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'backLogin', 'Regresar a página de ingreso','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'invalidToken', 'El token es inválido','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'expiredToken', 'El token ha expirado','0','0',0);

/*Menu*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'home', 'Inicio','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'dashboard', 'Panel de control','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'sols', 'Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'sols.enter', 'Ingreso y seguimiento','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'sols.aprob', 'Aprobar solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'sols.aut', 'Autorizar solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'sols.verif', 'Verificar entregas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'attend', 'Atender Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'attend.verif', 'Revisar autorizadas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'attend.shop', 'Compras pendientes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'attend.deliver', 'Entregas pendientes','0','0',0);

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'process', 'Procesos','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'process.shop', 'Compras','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'process.deliver', 'Entregas','0','0',0);

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'inventory', 'Inventario','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'inventory.in', 'Entradas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'inventory.out', 'Salidas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'inventory.view', 'Estado insumos','0','0',0);


INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'admin', 'Administración','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'users', 'Usuarios','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'centers', 'Centros','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'super', 'Configuración','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'studies', 'Estudios','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'accounts', 'Fondos','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemcat', 'Insumos','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'translation', 'Traducción','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'seccatalogs', 'Respuestas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'logout', 'Salir','0','0',0);


/*Usuarios*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'username', 'Usuario','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'userdesc', 'Descripción','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'useremail', 'Correo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'userlock', 'Bloqueado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usercred', 'Contraseña vencida','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'userexp', 'Cuenta vencida','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'userroles', 'Roles','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'user.updated', 'Usuario actualizado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'user.created', 'Usuario creado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'profile', 'Perfil','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'rolEnabled', 'Rol esta activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'rolDisabled', 'Rol esta inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'rolAdded', 'Rol agregado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'rolAll', 'Todos los roles ya están agregados!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usuarioEnabled', 'Usuario está activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usuarioDisabled', 'Usuario está inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usuarioAdded', 'Usuario agregado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usuarioAll', 'Todos los usuarios ya están agregados!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.users.model.UserSistema', 'Usuario','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.users.model.Authority', 'Rol de Usuario','0','0',0);



/*Cambio contrasenia*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'changepass', 'Cambiar contraseña..','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'credentials.expired', 'Su contraseña ha caducado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'pass.updated', 'Su contraseña ha sido actualizada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'password.repeat', 'Repita la contraseña','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'Pattern.password.format', 'Al menos 8 caracteres combinando mayúsculas, minúsculas, numeros y caracteres especiales','0','0',0);

/*Accesos*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'access', 'Accesos de usuario','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'lastAccess', 'Ultimo acceso','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'dateCredentials', 'Ultimo cambio de contrasena','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'session', 'Id de sesion','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ipaddress', 'Direccion IP','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'logindate', 'Fecha ingreso','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'logoutdate', 'Fecha salida','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'logouturl', 'URL salida','0','0',0);

/*Audit trail*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'audittrail', 'Bitacora de cambios','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'entityClass', 'Clase','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'entityName', 'Nombre','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'entityProperty', 'Propiedad','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'entityPropertyOldValue', 'Valor anterior','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'entityPropertyNewValue', 'Nuevo valor','0','0',0);

/*Roles*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_ADMIN', 'Administrador','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_CAMBIO_CONTRASENA', 'Cambio de contraseña','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_SUPER', 'Configuración','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_SOLS', 'Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_APRB', 'Aprobar Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_AUT', 'Autorizar Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_ATN', 'Atender Solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_PROC', 'Procesos','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ROLE_INV', 'Inventario','0','0',0);

/*Metadata*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'createdBy', 'Creado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'dateCreated', 'Fecha creacion','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'modifiedBy', 'Modificado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'dateModified', 'Fecha de modificación','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'active', 'Activo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'pasivo', 'Anulado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'addedBy', 'Agregado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'dateAdded', 'Fecha','0','0',0);

/*Acciones, todas las paginas*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'actions', 'Acciones','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'add', 'Agregar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'save', 'Guardar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'edit', 'Editar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'back', 'Regresar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cancel', 'Cancelar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'choose', 'Elegir','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'change', 'Cambiar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'disable', 'Deshabilitar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'enable', 'Habilitar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'end', 'Finalizar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'unlock', 'Desbloquear','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'lock', 'Bloquear','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'export', 'Exportar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ok', 'Aceptar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'search', 'Buscar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'confirm', 'Confirmar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'select', 'Seleccionar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'please.enter', 'Favor ingresar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('delete', 'Eliminar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('generate', 'Generar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('parameter', 'Parámetro', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('language', 'Idioma/Language', '0','0',0);

/*Acciones Solicitudes */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('sentAprob', 'Pasar a aprobación', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('sentAut', 'Pasar a autorización', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('sentCompra', 'Pasar a compra/entrega', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('notUndo', 'Esta acción no se puede deshacer', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('solSentAprob', 'Solicitud enviada a aprobación', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('solSentAut', 'Solicitud enviada a autorización', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('solSentCompra', 'Solicitud enviada para compra/entrega', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('noItems', 'No hay items en la solicitud', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('approve', 'Aprobar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('authorize', 'Autorizar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('notapprove', 'No Aprobar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('notauthorize', 'No Autorizar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('review', 'Revisar', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('finalizeReview', 'Terminar revisión', '0','0',0);

/*Acciones Items */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('sendCompra', 'Pasar a compra', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('sendDeliver', 'Pasar a entrega', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('viewBalance', 'Ver saldo', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('shopThis', 'Registrar compra de este producto', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('shopOther', 'Comprar otro producto', '0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('deliverThis', 'Entregar este producto', '0','0',0);

/*Mensajes generales, todas las paginas*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'enabled', 'Habilitado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'locked', 'Bloqueado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'notenabled', 'Deshabilitado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'notlocked', 'Desbloqueado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'process.errors', 'Han ocurrido errores en el proceso!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'process.success', 'El proceso se ha completado exitosamente!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'process.wait', 'Por favor espere..','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'noResults', 'No hay registros!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'all', 'Todos','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'options', 'Opciones','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'category', 'Categoría','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'value', 'Valor','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'denied', 'Acceso denegado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'deniedmessage', 'Lo sentimos, la página que solicitó no esta disponible con sus credenciales.','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'notfound', 'No encontrado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'notfoundmessage', 'Lo sentimos, la página que solicitó no pudo ser encontrada.','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'empty', 'En blanco','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ('selected', 'Seleccionados', '0','0',0);

/*Formularios Relacionado a Traducción */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'translations', 'Traducción de mensajes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'messageKey', 'Código mensaje','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'spanish', 'Español','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'english', 'Inglés','0','0',0);

/*Formularios Relacionado a Catalogos */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'seccatalogsform', 'Gestión de respuestas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ident', 'Identificador','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'catKey', 'Valor de la respuesta','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'catRoot', 'Catálogo Padre','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'pasive', 'De baja','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'order', 'Ordenamiento','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'opcionesCatalogo', 'Respuestas en este catálogo','0','0',0);

/*Centros */

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idCentro', 'Identificador','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'nombreCentro', 'Nombre del centro','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'puedeComprar', 'Comprador','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'centroEnabled', 'Centro está activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'centroDisabled', 'Centro está inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'centroAdded', 'Centro agregado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'centroAll', 'Todos los centros ya están agregados!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.relationship.UserCenter', 'Usuario/Centro','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Center', 'Centro','0','0',0);

/*Estudios */

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idEstudio', 'Identificador estudio','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'codEstudio', 'Código del estudio','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'nombreEstudio', 'Nombre del estudio','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estudioEnabled', 'Estudio está activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estudioDisabled', 'Estudio está inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estudioAdded', 'Estudio agregado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estudioAll', 'Todos los estudios ya están agregados!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Study', 'Estudio','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.relationship.StudyCenter', 'Estudio/Centro','0','0',0);

/*Fondos */

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idCuenta', 'Identificador fondo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'nombreCuenta', 'Nombre del fondo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cuentaEnabled', 'Fondo está activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cuentaDisabled', 'Fondo está inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Account', 'Fondo','0','0',0);

/*Solicitudes*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idSolicitud',  'Identificador solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'numSolicitud', 'Número de solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fecSolicitud', 'Fecha de solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fecRequerida', 'Requerido para el día','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fecAtendida',  'Fecha atendida','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ctrSolicitud', 'Centro que solicita','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estSolicitud', 'Estado solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'tipoSolicitud','Tipo solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usrSolicitud', 'Solicitado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'motivoCancelada', 'Cancelada por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'motivoCanceladaValidate', 'Favor ingresar el motivo de cancelación!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'observaciones','Motivo/Observaciones','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudEnabled', 'Solicitud está activa!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudDisabled', 'Solicitud está inactiva!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Solicitud', 'Solicitud','0','0',0);

/*Insumos*/
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idInsumo',  'Identificador insumo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'nombreInsumoEn',  'Nombre Inglés','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'nombreInsumoEs',  'Nombre Español','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'codigoBrand',  'Código/Modelo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'casaBrand',  'Marca','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'codigoDistribuidor',  'Código Distribuidor','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'casaDistribuidor',  'Distribuidor','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'codigoLocal',  'Cat Insumo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'tipoInsumo',  'Tipo de Insumo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'undMedida',  'Unidad de Medida','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'nivelAdvertencia',  'Nivel de advertencia','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'insumoEnabled', 'Insumo está activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'insumoDisabled', 'Insumo está inactivo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Insumo', 'Insumo','0','0',0);

/*Items */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idItem', 'Identificador registro','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitud', 'Solicitud','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usrSolicitaItem', 'Pedido por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ctrCompra', 'Solicitado a','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estudio', 'Estudios','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'insumo', 'NombreDelInsumo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cantSolicitada', 'Cantidad Solicitada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'presentacion', 'Presentación','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'contenidoPresentacion', 'Contenido','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'totalProducto', 'Total','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'autorizado', 'Autorizado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usrAutorizaItem', 'Autorizado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cantAutorizada', 'Cantidad Autorizada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fechaAutorizado', 'Fecha autorizado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'aprobado', 'Aprobado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usrApruebaItem', 'Aprobado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cantAprobada', 'Cantidad Aprobada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fechaAprobado', 'Fecha Aprobado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'estItem', 'Estado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'observacionesItem', 'Observaciones','0','0',0);	
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemEnabled', 'Este registro está activo!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemDisabled', 'Se ha eliminado el registro!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemNotApproved', 'Este insumo no fué aprobado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemNotAuthorized', 'Este insumo no fué autorizado!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Item', 'Insumo de solicitud','0','0',0);

/*Compras */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idCompra', 'Identificador compra','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'item', 'Insumo compra','0','0',0);	
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cuenta', 'Fondo a utilizar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'lugarCompra', 'Comprado por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fechaCompra', 'Fecha de compra','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'proveedor', 'Proveedor','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'numFactura', 'Número de factura','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cantComprada', 'Cantidad comprada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ingInv', 'Ingreso inventario','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'remCom', 'Quitar de compras pendientes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'envEnt', 'Enviar a entrega','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'compraDisabled', 'Compra está inactiva!','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Purchase', 'Compra','0','0',0);

/*Entregas */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'idEntrega', 'Identificador entrega','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemSolicitado', 'Insumo a entregar','0','0',0);	
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fechaEntrega', 'Fecha de entrega','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'usrRecibeItem', 'Recibido por','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'ent', 'Entregado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'numRecibo', 'Recibo num','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'cantEntregada', 'Cantidad entregada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'verificado', 'Entrega verificada','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'fechaVerificacion', 'Fecha de Verificacion','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'class ni.org.ics.solicitudes.domain.Deliver', 'Entrega','0','0',0);

/*Catalogos*/

/*Si No*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_SINO', NULL, NULL, NULL, '1', 0, '0', 'Catalogo Si No');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_SINO_SI','1','CAT_SINO',NULL,'0',1,'0','Si');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_SINO_NO','0','CAT_SINO',NULL,'0',2,'0','No');

/*Tipo de solicitud*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_SOL', NULL, NULL, NULL, '1', 0, '0', 'Catalogo Tipo de Solicitud');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_SOL_1','PROG','CAT_TIPO_SOL',NULL,'0',1,'0','Programado');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_SOL_2','MA','CAT_TIPO_SOL',NULL,'0',2,'0','Muestreo Anual');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_SOL_3','EMERG','CAT_TIPO_SOL',NULL,'0',3,'0','Emergencia');

/*Estado de solicitud*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL', NULL, NULL, NULL, '1', 0, '0', 'Estado de la Solicitud');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_1','SOLNUE','CAT_EST_SOL',NULL,'0',1,'0','Nueva solicitud');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_2','PENAPR','CAT_EST_SOL',NULL,'0',2,'0','Pendiente de aprobación');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_3','PENAUT','CAT_EST_SOL',NULL,'0',3,'0','Pendiente de autorización');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_4','PENREV','CAT_EST_SOL',NULL,'0',4,'0','Pendiente de revisión');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_5','PENCOM','CAT_EST_SOL',NULL,'0',4,'0','Pendiente de compra');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_6','PENENT','CAT_EST_SOL',NULL,'0',5,'0','Pendiente de entrega');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_7','SOLFIN','CAT_EST_SOL',NULL,'0',6,'0','Solicitud finalizada');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_SOL_8','SOLELM','CAT_EST_SOL',NULL,'0',7,'0','Solicitud eliminada');

/*Estado de item*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_ITEM', NULL, NULL, NULL, '1', 0, '0', 'Estado del item');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_ITEM_1','PENDIE','CAT_EST_ITEM',NULL,'0',1,'0','Pendiente');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_ITEM_2','COMPRA','CAT_EST_ITEM',NULL,'0',1,'0','Enviado a compra');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_ITEM_3','ENTREG','CAT_EST_ITEM',NULL,'0',1,'0','Listo para entrega');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_ITEM_4','COMPLE','CAT_EST_ITEM',NULL,'0',1,'0','Entregado');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_EST_ITEM_5','CANCEL','CAT_EST_ITEM',NULL,'0',1,'0','Cancelado');



/*Tipo de insumo*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_INSUMO', NULL, NULL, NULL, '1', 0, '0', 'Catalogo Tipo de Insumo');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_INSUMO_1','EQU','CAT_TIPO_INSUMO',NULL,'0',1,'0','Equipo');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_INSUMO_2','REA','CAT_TIPO_INSUMO',NULL,'0',2,'0','Reactivo');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_TIPO_INSUMO_3','MAT','CAT_TIPO_INSUMO',NULL,'0',3,'0','Materiales');


/*Aprobado de insumo*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_APR_INSUMO', NULL, NULL, NULL, '1', 0, '0', 'Catalogo Aprobacion de Insumo');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_APR_INSUMO_1','PENAP','CAT_APR_INSUMO',NULL,'0',1,'0','Pendiente');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_APR_INSUMO_2','NOAPR','CAT_APR_INSUMO',NULL,'0',2,'0','No Aprobado');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_APR_INSUMO_3','APRPA','CAT_APR_INSUMO',NULL,'0',3,'0','Aprobado Parcial');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_APR_INSUMO_4','APROB','CAT_APR_INSUMO',NULL,'0',4,'0','Aprobado');

/*Autorizado de insumo*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_AUT_INSUMO', NULL, NULL, NULL, '1', 0, '0', 'Catalogo Autorizacion de Insumo');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_AUT_INSUMO_1','PENAU','CAT_AUT_INSUMO',NULL,'0',1,'0','Pendiente');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_AUT_INSUMO_2','NOAUT','CAT_AUT_INSUMO',NULL,'0',2,'0','No Autorizado');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_AUT_INSUMO_3','AUTPA','CAT_AUT_INSUMO',NULL,'0',3,'0','Autorizado Parcial');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_AUT_INSUMO_4','AUTOR','CAT_AUT_INSUMO',NULL,'0',4,'0','Autorizado');

/*Unidad de medida*/
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_UND_MED', NULL, NULL, NULL, '1', 0, '0', 'Catalogo Unidad de Medida');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_UND_MED_1','UND','CAT_UND_MED',NULL,'0',1,'0','Unidad');
INSERT INTO mensajes (messageKey, catKey, catRoot, en, isCat, orden, catPasive, es) VALUES ('CAT_UND_MED_2','LT','CAT_UND_MED',NULL,'0',2,'0','Litro');

/*Reportes */
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'welcome', 'Bienvenido ','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'reportes', 'Reportes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'viewmore', 'Ver más','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'totalSolicitudes', 'Total de solicitudes','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesEstado', 'Solicitudes por estado','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesNuevas', 'Nuevas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesCompletas', 'Solicitudes completas','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesSinAprobar', 'Sin aprobar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesSinAutorizar', 'Sin autorizar','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesSinRevisar', 'A revisión','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesSinComprar', 'A compra','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesSinEntregar', 'Para entrega','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesEliminadas', 'Eliminadas','0','0',0);

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesCentro', 'Solicitudes por centro','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesTipo', 'Solicitudes por tipo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesUsuario', 'Solicitudes por usuario','0','0',0);

INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemTipo', 'Insumos por tipo','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'itemCateg', 'Insumos por categoria','0','0',0);
INSERT INTO mensajes (messageKey, es, catPasive, isCat, orden) VALUES ( 'solicitudesAtrasadas', 'Solicitudes atrasadas','0','0',0);






