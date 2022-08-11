CREATE DATABASE IF NOT EXISTS DbContabilly;
USE DbContabilly;
CREATE TABLE IF NOT EXISTS Proveedor (
	IdProveedor INT AUTO_INCREMENT PRIMARY KEY,
	Nombre VARCHAR(100),
	Identificacion VARCHAR(13),
	Usuario VARCHAR(20),
	Contrasena VARCHAR(50),
	Email VARCHAR(50),
	Numero VARCHAR(20),
	Pais VARCHAR(50),
	Ciudad VARCHAR(50),
	Direccion VARCHAR(200)
);
                        
CREATE TABLE IF NOT EXISTS Producto (
	IdProducto INT AUTO_INCREMENT PRIMARY KEY,
	Descripcion VARCHAR(100),
	Stock INT,
	ValorU FLOAT,
	ValorCompra FLOAT,
	ValorVenta FLOAT,
	Activo BOOL, 
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	Valoracion FLOAT
);
                        
CREATE TABLE IF NOT EXISTS Comprador (
	IdComprador INT AUTO_INCREMENT PRIMARY KEY,
	Nombre VARCHAR(100),
	Identifcacion VARCHAR(13),
	Usuario VARCHAR(20),
	Contrasena VARCHAR(50),
	Email VARCHAR(50),
	Numero VARCHAR(20),
	Pais VARCHAR(50),
	Ciudad VARCHAR(50),
	Direccion VARCHAR(200)
);
CREATE TABLE IF NOT EXISTS Oferta( #Oferttaaaaaaaaa!!!!
	IdOferta INT AUTO_INCREMENT PRIMARY KEY,
	IdProducto INT ,
	Minimo INT,
	Maximo INT,
	Descripcion VARCHAR(500),
	ActualProductos INT,
	FechaLimite DATETIME,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	Estado BOOL,
	FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

CREATE TABLE Rol(
	IdRol INT AUTO_INCREMENT PRIMARY KEY,
    Rol VARCHAR(30),
    FechaCreacion DATETIME
);

CREATE TABLE Usuario (
	IdUsuario INT AUTO_INCREMENT PRIMARY KEY,
    IdRol INT,
	Nombre VARCHAR(100),
	Identifcacion VARCHAR(13),
	Usuario VARCHAR(20),
	Contrasena VARCHAR(50),
	Email VARCHAR(50),
	Numero VARCHAR(20),
	Pais VARCHAR(50),
	Ciudad VARCHAR(50),
	Direccion VARCHAR(200),
    FOREIGN KEY (IdRol) REFERENCES Rol(IdRol)
);

CREATE TABLE IF NOT EXISTS Notificacion (
	IdNotificacion INT AUTO_INCREMENT PRIMARY KEY,
	IdUsuario INT,
    IdOferta INT,
    Descripcion VARCHAR(200),
    FechaCrea DATETIME,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdOferta) REFERENCES Oferta(IdOferta)
);

CREATE TABLE IF NOT EXISTS EstadosOferta(
	IdEstadosOferta INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion Varchar(50),
    FechaCrea DATETIME,
    Activo BOOL
);

CREATE TABLE IF NOT EXISTS OfertaComprador(
	IdOfertaComprador INT AUTO_INCREMENT PRIMARY KEY,
    IdOferta INT, 
    IdComprador INT,
    Cantidad INT, #Cantidad de productos escogidos por ese comprador al unirse
    Estado INT,
    FOREIGN KEY (IdOferta) REFERENCES Oferta(IdOferta),
    FOREIGN KEY (IdComprador) REFERENCES Comprador(IdComprador)
);

CREATE TABLE IF NOT EXISTS ValoracionProducto(
	IdValoracionProducto INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT,
    IdProducto INT,
    Comentario VARCHAR(1000),
    Valoracion FLOAT,
    FechaCrea DATETIME,
    FOREIGN KEY (IdUsuario) REFERENCES Comprador(IdComprador),
    FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto)
);

CREATE TABLE Reportes(
	IdReporte INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT,
    IdOferta INT,
    Motivo VARCHAR(200),
    FechaCrea DATETIME,
    FOREIGN KEY (IdUsuario) REFERENCES Comprador(IdComprador),
    FOREIGN KEY (IdOferta) REFERENCES Oferta(IdOferta)
);

#Tabla de pagos pendientes
CREATE TABLE Compra(
	IdCompra INT AUTO_INCREMENT PRIMARY KEY,
	IdProveedor INT,
    IdComprador INT,
    IdOferta INT,
    #IdOfertaComprador INT,
    Cantidad INT,
    Total FLOAT,
    Descripcion VARCHAR(500),
    Observacion VARCHAR(300),
    Fecha DATETIME,
    IdEstado INT, #Clave foraneo a estadosOferta
    MetodoPago VARCHAR(10), #Este campo sera para saber si fue reserva o pago directo
    PagadoAProveedor BOOL,  #Es para verificar si ya se ha completado el pago al proveedor!!
    FOREIGN KEY (IdProveedor) REFERENCES Usuario(IdUsuario),
    #FOREIGN KEY (IdOfertaComprador) REFERENCES OfertaComprador(IdOfertaComprador),
    FOREIGN KEY (IdEstado) REFERENCES EstadosOferta(IdEstadosOferta),
    FOREIGN KEY (IdComprador) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdOferta) REFERENCES Oferta(IdOferta)
);

/*CREATE TABLE Venta(
	IdVenta INT AUTO_INCREMENT PRIMARY KEY,
    IdComprador INT,
);*/

INSERT INTO Rol(Rol, FechaCreacion) VALUES 
('comprador', NOW()),
('proveedor', NOW()),
('administrador', NOW());

#ALTER TABLE Usuario
#DROP COLUMN Identifcacion,
#ADD Identificacion VARCHAR(13);

INSERT INTO Usuario(IdRol, Nombre, Identificacion, Usuario, Contrasena, Email, Numero, Pais, Ciudad, Direccion) VALUES 
(1, 'Walther Duran', '1205801515', 'wduran', 'wduran1234', 'wduran@gmail.com', '+593998950947', 'Ecuador', 'Guayaquil', 'Samanes'),
(1, 'Karla Duran', '1205801516', 'kduran', 'kduran1234', 'kduran@gmail.com', '+593998950948', 'Ecuador', 'Guayaquil', 'Samanes'),
(2, 'Helena Crespo', '0905801320', 'hcrespo', 'hcrespo1234', 'hcrespo@gmail.com', '+593998950948', 'Austria', 'Vienna', 'Auskunft-022'),
(2, 'Algodón S.A.', '0905801320', 'algodonsa', 'algodonsa1234', 'algodonsa@gmail.com', '+593998950948', 'Ecuador', 'Babahoyo', 'Calle 42'),
(2, 'Electrika', '0905801320', 'electrika', 'electrika1234', 'electrika@gmail.com', '+593998950948', 'Ecuador', 'Manta', 'Calle 23'),
(2, 'Agrícola S.A.', '0905801320', 'agricola', 'agricola1234', 'agricola@gmail.com', '+593998950948', 'Ecuador', 'Ventanas', 'Calle 13'),
(2, 'Brocolistos', '0905801320', 'brocolistos', 'brocolistos1234', 'brocolistos@gmail.com', '+593998950948', 'Ecuador', 'Guayaquil', 'Sur'),
(3, 'Carlos Duran', '1205801325', 'cduran', 'cduran1234', 'cduran@gmail.com', '+593998950948', 'Ecuador', 'Guayaquil', 'Auskunft-022');

INSERT INTO EstadosOferta(Descripcion, FechaCrea, Activo) VALUES
('En curso', NOW(), true);

#ADD IDPROVEEDOR TO OFERTA
ALTER TABLE Oferta
ADD IdProveedor INT,
ADD FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor);

#ADD TIPO DE ESTADO
ALTER TABLE Oferta
ADD IdEstadosOferta INT,
ADD	FOREIGN KEY (IdEstadosOferta) REFERENCES EstadosOferta(IdEstadosOferta);


CREATE TABLE CatProducto(
	IdCatProducto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    GoogleCodeRoundedIcon VARCHAR(20)
);

INSERT INTO CatProducto(Nombre, GoogleCodeRoundedIcon) VALUES
('Artesanías', 'pan_tool'),
('Frutas', 'atr'),
('Legumbres', 'local_florist'),
('Materia Prima', 'emoji_objects'),
('Vestimenta', 'checkroom'),
('Construcción', 'construction'),
('Varios', 'sports_soccer');

CREATE TABLE ProvFavorito(
	IdProvFavorito INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuarioComp INT,
    IdUsuarioProv INT,
    FOREIGN KEY (IdUsuarioComp) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdUsuarioProv) REFERENCES Usuario(IdUsuario)
);

INSERT INTO ProvFavorito(IdUsuarioComp, IdUsuarioProv) VALUES
(2,4),
(2,5),
(2,6),
(2,7); 

#DROP COLUMNS: VALORCOMPRA VALORVENTA FROM PRODUCTO
ALTER TABLE Producto
DROP COLUMN ValorCompra,
DROP COLUMN ValorVenta;

#ADD ID_PROVEEDOR TO PRODUCT
ALTER TABLE Producto
ADD IdProveedor INT,
ADD	FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor);

#ADD ID_CATEGORY TO PRODUCT
ALTER TABLE Producto
ADD IdCatProducto INT,
ADD FOREIGN KEY (IdCatProducto) REFERENCES CatProducto(IdCatProducto); 

#ADD BLOB TO PRODUCT
ALTER TABLE Producto
ADD UrlImg TEXT;

#ADD NAME TO PRODUCT
ALTER TABLE Producto
ADD Name VARCHAR(100);

CREATE TABLE TipoNotificacion(
	IdTipoNotificacion INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(20),
    GoogleCodeRoundedIcon VARCHAR(20)
);

#ADD TIPO DE NOTIFICACION
ALTER TABLE Notificacion
ADD IdTipoNotificacion INT,
ADD	FOREIGN KEY (IdTipoNotificacion) REFERENCES TipoNotificacion(IdTipoNotificacion);
